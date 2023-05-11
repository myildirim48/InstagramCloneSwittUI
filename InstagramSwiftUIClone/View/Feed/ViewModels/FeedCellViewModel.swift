//
//  FeedCellViewModel.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 7.05.2023.
//

import SwiftUI
import Firebase

class FeedCellViewModel: ObservableObject {

    @Published var post: Post
    
    private let userService = UserService()
    private var currentUser: User?
    
    var likeString: String {
        let label = post.likes == 1 ? "like" : "likes"
        return "\(post.likes) \(label)"
    }
    
    var timeStampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: post.timestamp.dateValue(), to: Date()) ?? "n/a"
    }
    
    init(post: Post) {
        self.post = post
        checkIfUserLikedPost()
        fetchCurrentUser()
    }
    
    func like() {
        guard let currentUser else { return }
        guard let currentUserUid = currentUser.id else { return }
        guard let postId = post.id else { return }
        COLLECTION_POSTS.document(postId)
            .collection("post-likes")
            .document(currentUserUid)
            .setData([:]) { _ in
                COLLECTION_USERS.document(currentUserUid)
                    .collection("user-likes")
                    .document(postId)
                    .setData([:]) { _ in
                        
                        COLLECTION_POSTS.document(postId).updateData(["likes" : self.post.likes + 1])
                        
                        NotificationsViewModel.uploadNotification(toUid: self.post.ownerUid,
                                                                  currentUser: currentUser,
                                                                  type: .like,
                                                                  post: self.post)
                        
                        self.post.didLike = true
                        self.post.likes += 1
                    }
            }
    }
    
    func unlike() {
        guard post.likes > 0 else { return }
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        guard let postId = post.id else { return }
        COLLECTION_POSTS.document(postId)
            .collection("post-likes").document(currentUserUid).delete { _ in
                COLLECTION_USERS.document(currentUserUid)
                    .collection("user-likes").document(postId).delete { _ in
                        COLLECTION_POSTS.document(postId).updateData(["likes" : self.post.likes - 1])
                        self.post.didLike = false
                        self.post.likes -= 1
                    }
            }
    }
    
    func checkIfUserLikedPost() {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_USERS.document(currentUserUid).collection("user-likes").document(postId)
            .getDocument { snapshot, error in
                guard let didLike = snapshot?.exists else { return }
                self.post.didLike = didLike
        }
    }
    
    
    func fetchCurrentUser() {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        userService.fetchUser(withUid: userUid) { user in
            self.currentUser = user
        }
    }
}
