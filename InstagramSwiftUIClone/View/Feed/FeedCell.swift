//
//  FeedCell.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 3.05.2023.
//

import SwiftUI

struct FeedCell: View {
    
    @ObservedObject var viewModel: FeedCellViewModel
    
    var didLike : Bool { return viewModel.post.didLike ?? false }
    
    init(viewModel: FeedCellViewModel) {
        self.viewModel = viewModel
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
//            User info
            HStack {
                NavigationLink {
//                    ProfileView(user: <#T##User#>)
                } label: {
                    LoadableImage(imageType: .profile,imgUrl: viewModel.post.ownerImageUrl, size: 36)
                    
                    Text(viewModel.post.ownerUserName)
                        .font(.system(size: 14,weight: .semibold))
                    
                }

            }.padding(.leading)
//            post image
     
            LoadableImage(imageType: .post, imgUrl: viewModel.post.imageUrl)
                    .frame(maxWidth: 400,maxHeight: 440)
                    
            
//            action buttons
            HStack(spacing: 24) {
                Button {
                    didLike ? viewModel.unlike() : viewModel.like()
                } label: {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(didLike ? .red : .black)
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                                            
                }
                NavigationLink {
                    CommentsView(post: viewModel.post)
                } label: {
                        Image(systemName: "bubble.right")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                            .font(.system(size: 20))
                }

                Button {
                    
                } label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                                            
                }

            }.padding(.leading,15)
//            caption
            VStack(alignment: .leading,spacing: 5) {
                Text(viewModel.likeString)
                    .font(.system(size: 14,weight: .bold))
                HStack {
                    Text(viewModel.post.ownerUserName)
                        .font(.system(size: 14,weight: .bold))
                    +
                    Text(" \(viewModel.post.caption)")
                        .font(.system(size: 15))
                }
                
                Text(viewModel.timeStampString)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    
            }.padding(.leading)
         Spacer()
        }
    }
}
