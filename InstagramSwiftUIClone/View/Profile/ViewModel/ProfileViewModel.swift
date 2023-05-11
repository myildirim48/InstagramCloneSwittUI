//
//  ProfileViewModel.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 6.05.2023.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class ProfileViewModel: ObservableObject {
    
    @Published var user: User
    
    private let userService = UserService()
    private var currentUser: User?
    
    init(user: User) {
        self.user = user
        checkIfUserFollowed()
        fetchUser()
        fetchUserStats()
    }

    
    func follow() {
        guard let uid = user.id else { return }
        guard let currentUser else { return }
        userService.follow(uid: uid) { _ in
            self.user.isFollowed = true
            
            NotificationsViewModel.uploadNotification(toUid: uid, currentUser: currentUser, type: .follow)
        }
    }
    
    func unfollow() {
        guard let uid = user.id else { return }
        userService.unfollow(uid: uid) { _ in
            self.user.isFollowed = false
        }
    }
    
    func checkIfUserFollowed() {
        guard !user.isCurrentUser else { return }
        guard let uid = user.id else { return }
        
        UserService.checkIfUserFollower(uid: uid) { isFollowed in
            self.user.isFollowed = isFollowed
        }
    }
    
    //MARK: - User
    func fetchUser() {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        userService.fetchUser(withUid: userUid) { user in
            self.currentUser = user
        }
    }
    
    func fetchUserStats(){
        guard let uid = user.id else { return }
        
        COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { snapshot, error in
            guard let following = snapshot?.documents.count else { return }
            
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, error in
                guard let followers = snapshot?.documents.count else { return }
                
                COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { snapshot, error in
                    guard let posts = snapshot?.documents.count else { return }
                    
                    self.user.stats = UserStats(following: following, posts: posts, followers: followers)
                }
            }
        }
    }
}
