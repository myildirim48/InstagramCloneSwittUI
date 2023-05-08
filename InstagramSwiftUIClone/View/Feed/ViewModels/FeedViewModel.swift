//
//  FeedViewModel.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 7.05.2023.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    private let postService = PostService()
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts(){
        postService.fetchPosts { posts in
            self.posts = posts
        }
    }
}
