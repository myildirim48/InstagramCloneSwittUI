//
//  EditProfileViewModel.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 11.05.2023.
//

import SwiftUI


class EditProfileViewModel: ObservableObject {
    
    @Published var uploadCompleted = false
    
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func saveUserData(_ bio: String){
        guard let uid = user.id else { return }
        
        COLLECTION_USERS
            .document(uid).updateData(["bio": bio]) { _ in
                self.user.bio = bio
                self.uploadCompleted = true
            }
    }
}
