//
//  NotificationsViewModel.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 8.05.2023.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class NotificationsViewModel: ObservableObject {
    @Published var notifications = [Notification]()
    
    init() {
        fetchNotifications()
    }

    func fetchNotifications() {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_NOTIFICATIONS.document(currentUserUid).collection("user-notifications")
            .order(by: "timestamp", descending: true)
        
        query.getDocuments { snapShot, error in
            guard let documents = snapShot?.documents else { return }
            self.notifications = documents.compactMap({ try? $0.data(as: Notification.self) })
        }
    }
    
    static func uploadNotification(toUid uid: String, currentUser: User ,type: NotificationType, post: Post? = nil)  {
        guard let currentUserID = currentUser.id else { return }
        
        var data : [String : Any] = ["timestamp" : Timestamp(date: Date()),
                                     "username" : currentUser.username,
                                     "uid" : currentUserID,
                                     "profileImageUrl" : currentUser.profileImageurl,
                                     "type" : type.rawValue]
        
        if let post = post, let postId = post.id {
            data["postId"] = postId
        }
        
        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications")
            .addDocument(data: data)
    }

}
