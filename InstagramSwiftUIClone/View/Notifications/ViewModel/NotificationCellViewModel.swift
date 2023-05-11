//
//  NotificationCellViewModel.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 8.05.2023.
//

import SwiftUI

class NotificationCellViewModel: ObservableObject {
    @Published var notification: Notification
    
    
    private let userService = UserService()
    private var user: User?
    
    var timeStampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timestamp.dateValue(), to: Date()) ?? "n/a"
    }
    
    init(notification: Notification) {
        self.notification = notification
        fetchUser()
        checkIfUserFollowed()
        fetchNotificationPost()
        fetchNotificationUser()
    }
    func follow() {
        guard let user else { return }
        userService.follow(uid: notification.uid) { _ in
            self.notification.userIsFollowed = true
            
            NotificationsViewModel.uploadNotification(toUid: self.notification.uid, currentUser: user, type: .follow)
        }
    }
    
    func unfollow() {
        userService.unfollow(uid: notification.uid) { _ in
            self.notification.userIsFollowed = false
        }
    }
    
    func checkIfUserFollowed() {
        guard notification.type == .follow else { return }
        
        UserService.checkIfUserFollower(uid: notification.uid) { isFollowed in
            self.notification.userIsFollowed = isFollowed
        }
    }
    func  fetchNotificationPost(){
        guard let postId = notification.postId else { return }
        
        COLLECTION_POSTS.document(postId).getDocument { snapshot, _ in
            self.notification.post = try? snapshot?.data(as: Post.self)
        }
    }
    
    //MARK: - User
    
    func fetchUser() {
        userService.fetchUser(withUid: notification.uid) { user in
            self.user = user
        }
    }
    
    func fetchNotificationUser() {
        userService.fetchUser(withUid: notification.uid) { user in
            self.notification.user = user
        }
    }
}
