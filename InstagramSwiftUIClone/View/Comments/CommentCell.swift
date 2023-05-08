//
//  CommentCell.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 7.05.2023.
//

import SwiftUI

struct CommentCell: View {
    
    private let comment: Comments
    
    init(comment: Comments) {
        self.comment = comment
    }
    
    var body: some View {
        HStack {
            LoadableImage(imageType: .profile, imgUrl: comment.profileImageUrl,size: 36)
            
            Text(comment.username)
                .font(.system(size: 14,weight: .semibold))
            +
            
            Text(" \(comment.commentText)")
                .font(.system(size: 14 ))
            
            Spacer()
            
            Text("\(comment.timestamp)")
                .foregroundColor(.gray)
                .font(.system(size: 12))

        }.padding(.horizontal)
    }
}

