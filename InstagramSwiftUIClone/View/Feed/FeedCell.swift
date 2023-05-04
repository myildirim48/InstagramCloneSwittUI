//
//  FeedCell.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 3.05.2023.
//

import SwiftUI

struct FeedCell: View {
    var body: some View {
        VStack(alignment: .leading) {
//            User info
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .cornerRadius(36)
                
                Text("joker")
                    .font(.system(size: 14,weight: .semibold))
                
            }.padding(.leading)
//            post image
     
                Image("darth-vader")
                    .resizable()
                    .scaledToFill()
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
                Text("0 Likes")
                    .font(.system(size: 14,weight: .bold))
                HStack {
                    Text("batman")
                        .font(.system(size: 14,weight: .bold))
                    +
                    Text(" all man have limits. ")
                        .font(.system(size: 15))
                }
                
                Text("2d")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    
            }.padding(.leading)
         
        }
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell()
    }
}
