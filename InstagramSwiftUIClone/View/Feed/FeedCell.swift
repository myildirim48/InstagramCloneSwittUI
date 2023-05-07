//
//  FeedCell.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 3.05.2023.
//

import SwiftUI

struct FeedCell: View {
    
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
//            User info
            HStack {
                LoadableImage(imageType: .profile,imgUrl: post.ownerImageUrl, size: 36)
                
                Text(post.ownerUserName)
                    .font(.system(size: 14,weight: .semibold))
                
            }.padding(.leading)
//            post image
     
            LoadableImage(imageType: .post, imgUrl: post.imageUrl)
                    .frame(maxHeight: 440)
                    
            
//            action buttons
            HStack(spacing: 24) {
                Button {
                    
                } label: {
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                                            
                }
                Button {
                    
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
                Text("\(post.likes) Likes")
                    .font(.system(size: 14,weight: .bold))
                HStack {
                    Text(post.ownerUserName)
                        .font(.system(size: 14,weight: .bold))
                    +
                    Text(" \(post.caption)")
                        .font(.system(size: 15))
                }
                
                Text("2d")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    
            }.padding(.leading)
         
        }
    }
}

//struct FeedCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedCell()
//    }
//}
