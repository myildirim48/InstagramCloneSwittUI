//
//  CommentsViewModel.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 7.05.2023.
//

import SwiftUI
import Firebase

class CommentsViewModel: ObservableObject {
    
    @Published var comments = [Comments]()
    
    private var user: User?
    private let userService = UserService()
    private let post: Post
    
    init(post: Post) {
        self.post = post
        fetchuser()
        fetchComment()
    }
    
    func uploadComment(commentText: String) {
        guard let user else { return }
        guard let postId = post.id else { return }
        let data : [String : Any] = ["username" : user.username,
                    "profileImageUrl" : user.profileImageurl,
                    "uid" : user.id ?? "",
                    "timestamp" : Timestamp(date: Date()),
                    "postOwnerUid" : post.ownerUid,
                    "commentText" : commentText]
        COLLECTION_POSTS
            .document(postId).collection("post-comments").addDocument(data: data) { error in
                if let error {
                    print("ERROR : Error while uploading comment \(error.localizedDescription)")
                }
                
                NotificationsViewModel.uploadNotification(toUid: self.post.ownerUid,
                                                          currentUser: user,
                                                          type: .comment,
                                                          post: self.post)
            }
        
    }
    
    func fetchComment(){
        guard let postId = post.id else { return }

        let query = COLLECTION_POSTS.document(postId).collection("post-comments")
            .order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, error in
            guard let addedDocs = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            self.comments.append(contentsOf: addedDocs.compactMap({ try? $0.document.data(as: Comments.self) }))
            
//            snapshot?.documentChanges.forEach({ changes in
//                if changes.type == .added {
//                    guard let comment = try? changes.document.data(as: Comments.self) else { return }
//                    self.comments.append(comment)
//                }
//            })
        }
    }
    //MARK: - Fetch User
    func fetchuser() {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        userService.fetchUser(withUid: userUid) { user in
            self.user = user
        }
    }
}
