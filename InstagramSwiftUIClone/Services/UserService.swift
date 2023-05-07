//
//  UserService.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 6.05.2023.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    func follow(uid: String, completion: @escaping ((Error?) -> Void)){
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
    
    func unfollow(uid: String, completion: @escaping ((Error?) -> Void)){
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
    
    //MARK: - Fetch user
    
    func fetchUser(withUid uid: String,completion: @escaping(User) -> Void) {
       COLLECTION_USERS
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot else { return }
                
                guard let user = try? snapshot.data(as: User.self) else { return }
                completion(user)
            }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void) {
        COLLECTION_USERS
            .getDocuments { snapshot, err in
                if let err {
                    print("DEBUG : Error \(err.localizedDescription)")
                }
                guard let document = snapshot?.documents else { return }
                let users = document.compactMap { try? $0.data(as: User.self) }
                
                completion(users)
            }
    }
    
}
