//
//  UserService.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 6.05.2023.
//

import Firebase

struct UserService {
    
    static func follow(uid: String, completion: @escaping ((Error?) -> Void)){
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING
            .document(currentUserUid)
            .collection("user-following")
            .document(uid)
            .setData([:]) { _ in
                COLLECTION_FOLLOWERS.document(uid).collection("user-followers")
                    .document(currentUserUid).setData([:], completion: completion)
            }
    }
    
    static func unfollow(uid: String, completion: @escaping ((Error?) -> Void)){
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING
            .document(currentUserUid)
            .collection("user-following")
            .document(uid)
            .delete { _ in
                COLLECTION_FOLLOWERS
                    .document(uid)
                    .collection("user-followers")
                    .document(currentUserUid)
                    .delete(completion: completion)
            }
    }
    
    static func checkIfUserFollower(uid: String, completion: @escaping(Bool) -> Void){
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }

        COLLECTION_FOLLOWING
            .document(currentUserUid)
            .collection("user-following")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let isFollowed = snapshot?.exists else { return }
                completion(isFollowed)
            }
    }
}
