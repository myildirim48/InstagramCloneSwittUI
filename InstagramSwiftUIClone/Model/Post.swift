//
//  Post.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 7.05.2023.
//

import FirebaseFirestoreSwift
import Firebase

struct Post: Decodable,Identifiable {
    @DocumentID var id: String?
    let caption: String
    let imageUrl: String
    let likes: Int
    let ownerImageUrl: String
    let ownerUid: String
    let timestamp: Timestamp
    let ownerUserName: String
}
