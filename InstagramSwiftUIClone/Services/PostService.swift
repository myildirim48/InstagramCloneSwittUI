//
//  PostService.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 7.05.2023.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct PostService {
    func fetchPosts(completion: @escaping([Post]) -> Void) {
        COLLECTION_POSTS.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            let posts = documents.compactMap({ try? $0.data(as: Post.self) })
            completion(posts)
            
            print(posts.count)
            posts.forEach { post in
                print("DEBUG: Post Url: \(post.imageUrl)")
            }
            
        }
    }
    
    func fetchPosts(forUserUid uid: String, completion: @escaping([Post]) -> Void){
        COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let posts = documents.compactMap { try? $0.data(as: Post.self) }
                completion(posts)
            }
    }
}
