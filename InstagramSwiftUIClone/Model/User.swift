//
//  User.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 5.05.2023.
//

import Firebase
import FirebaseFirestoreSwift

struct User: Identifiable,Decodable {
    @DocumentID var id: String?
    let email: String
    let username: String
    let fullname: String
    let profileImageurl: String
    
    var bio: String?
    var isFollowed: Bool? = false
    var stats: UserStats? 
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id}

}

struct UserStats: Decodable {
    var following: Int
    var posts: Int
    var followers: Int
}
