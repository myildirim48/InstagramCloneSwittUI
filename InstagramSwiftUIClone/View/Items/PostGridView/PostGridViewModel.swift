//
//  PostGridViewModel.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 7.05.2023.
//

import SwiftUI

enum PostGridConfiguration {
    case explore
    case profile(String)
}

class PostGridViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    
    let config: PostGridConfiguration
    
    private let postService = PostService()
    
    init(config: PostGridConfiguration) {
        self.config = config
        self.fetchPosts(forConfig: config)
    }
    
    func fetchExplorePosts() {
        postService.fetchPosts { posts in
            self.posts = posts
        }
    }
    
    func fetchUserPosts(forUid uid: String) {
        postService.fetchPosts(forUserUid: uid) { posts in
            self.posts = posts
        }
    }
    
    func fetchPosts(forConfig config: PostGridConfiguration) {
        switch config {
        case .explore:
            fetchExplorePosts()
        case .profile(let uid):
            fetchUserPosts(forUid: uid)
        }
    }
}
