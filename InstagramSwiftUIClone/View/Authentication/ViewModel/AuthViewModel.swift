//
//  AuthViewModel.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 4.05.2023.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @ Published var userSessions: FirebaseAuth.User?
    
    init() {
        self.userSessions = Auth.auth().currentUser
    }
    
    func login()  {
        
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
                
                Firestore.firestore().collection("users")
                    .document(user.uid)
                    .setData(data) { _ in
                        self.userSessions = user
                        print("DEBUG: User registered image uploaded")
                    }
            }
        }
        
    }
    
    func resetPassword()  {
        
    }
    
    func fetchUser()  {
        
    }
}
