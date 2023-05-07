//
//  PostGridView.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 4.05.2023.
//

import SwiftUI

struct PostGridView: View {
    private let items = [GridItem(.flexible(), spacing: 2),
                         GridItem(.flexible(), spacing: 2),
                         GridItem(.flexible(), spacing: 2)]
    private let width = UIScreen.main.bounds.width / 3.3
    
    let config: PostGridConfiguration
    
    @ObservedObject var viewModel : PostGridViewModel
    
    init(config: PostGridConfiguration) {
        self.config = config
        self.viewModel = PostGridViewModel(config: config)
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: items, spacing: 2) {
                    ForEach(viewModel.posts) { posts in
                        NavigationLink {
                            FeedView()
                        } label: {
                            Color.clear.overlay {
                                LoadableImage(imageType: .post, imgUrl: posts.imageUrl)
                            }                    .frame(maxWidth: .infinity)
                                .aspectRatio(1, contentMode: .fill) // << for square !!
                                .clipped()
                            
                        }

                    }

                }
            }
        }

    }
}
