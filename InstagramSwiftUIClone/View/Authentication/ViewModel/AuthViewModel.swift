//
//  AuthViewModel.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 4.05.2023.
//

import SwiftUI
import Firebase
class AuthViewModel: ObservableObject {
    @Published var userSessions: FirebaseAuth.User?
    @Published var currentUser: User?
    
    
    init() {
        self.userSessions = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(withEmail email: String, password: String)  {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                print("DEBUG : Error while creating user. \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSessions = user
            self.fetchUser()
        }
    }
    
    func logOut() {
        userSessions = nil
        try? Auth.auth().signOut()
    }
    
    func register(withEmail email: String,
                  password: String,
                  image: UIImage?,
                  fullname: String,
                  username: String)  {
            
        guard let image else { return }
        ImageUploader.uploadImage(image: image) { imgrUrl in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error {
                    print("DEBUG : Error while creating user, \(error.localizedDescription)")
                }
                guard let user = result?.user else { return }
                self.userSessions = user
                
                let data = ["email" : email,
                            "username" : username.lowercased(),
                            "fullname" : fullname,
                            "profileImageurl" : imgrUrl,
                            "uid": user.uid]
                
                COLLECTION_USERS
                    .document(user.uid)
                    .setData(data) { _ in
                        self.userSessions = user
                        self.fetchUser()
                }
            }
        }
    }
    
    func resetPassword()  {
        
    }
    
    func fetchUser()  {
        guard let uid = userSessions?.uid else { return }
       COLLECTION_USERS
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot else { return }
                
                guard let user = try? snapshot.data(as: User.self) else { return }
                
                if user.id == self.userSessions?.uid {
                    self.currentUser = user
                }
            }
    }
}
