//
//  Comments.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 7.05.2023.
//

import Firebase
import FirebaseFirestoreSwift
struct Comments: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let commentText: String
    let postOwnerUid: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let uid: String
}
