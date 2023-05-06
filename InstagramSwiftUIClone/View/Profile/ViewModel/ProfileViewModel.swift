//
//  ProfileViewModel.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 6.05.2023.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
        checkIfUserFollowed()
    }
    
    func follow() {
        guard let uid = user.id else { return }
        UserService.follow(uid: uid) { _ in
            self.user.isFollowed = true
        }
    }
    
    func unfollow() {
        guard let uid = user.id else { return }
        UserService.unfollow(uid: uid) { _ in
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
}
