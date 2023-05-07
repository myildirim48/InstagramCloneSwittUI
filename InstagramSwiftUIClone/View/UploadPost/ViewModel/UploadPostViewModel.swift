//
//  UploadPostViewModel.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 6.05.2023.
//

import SwiftUI
import Firebase

class UploadPostViewModel: ObservableObject {
    
    private let userService = UserService()
    private var currentUser: User?
    
    
    init() {
        fetchUser()
    }

    
    func uploadPost(caption: String, image: UIImage, completion: @escaping((Error?) -> Void)) {
        
        guard let user = currentUser else { return }
        guard let userID = currentUser?.id else { return }
        
        ImageUploader.uploadImage(image: image, type: .post) { imageUrl in
            let data = ["caption" : caption,
                        "timestamp" : Timestamp(date: Date()),
                        "likes" : 0,
                        "imageUrl" : imageUrl,
                        "ownerUid" : userID,
                        "ownerImageUrl" : user.profileImageurl,
                        "ownerUserName" : user.username] as [String : Any]
             
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
    
    
    //MARK: - Fetch user
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        userService.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }
}
