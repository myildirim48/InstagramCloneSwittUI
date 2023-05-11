//
//  NotificationCell.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 4.05.2023.
//

import SwiftUI

struct NotificationCell: View {

    @ObservedObject var viewModel: NotificationCellViewModel
    
    var isFollowed: Bool {
        return viewModel.notification.userIsFollowed ?? false
    }
    
    init(viewModel: NotificationCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack{
                NavigationLink {
                    if let user = viewModel.notification.user {
                        ProfileView(user: user)
                    }
                } label: {
                    LoadableImage(imageType: .profile, imgUrl: viewModel.notification.profileImageUrl)
                        Text(viewModel.notification.username)
                            .font(.system(size: 14,weight: .semibold))
                    +
                        Text(viewModel.notification.type.notificationMessage)
                            .font(.system(size: 14))
                    +
                        Text(" \(viewModel.timeStampString)").font(.system(size: 12)).foregroundColor(.gray)

                }
            Spacer()
            
            if viewModel.notification.type != .follow {
                if let post = viewModel.notification.post {
                    NavigationLink {
                        FeedCell(viewModel: FeedCellViewModel(post: post))
                    } label: {
                        LoadableImage(imageType: .post, imgUrl: post.imageUrl)
                            .frame(width: 35, height: 35)
                    }

                }
            }else {
                Button {
                    isFollowed ? viewModel.unfollow() : viewModel.follow()
                } label: {
                    Text(isFollowed ? "Following" : "Follow")
                        .font(.system(size: 15,weight: .semibold))
                        .frame(width: 95, height: 28, alignment: .center)
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: isFollowed ? 1 : 0)
                        })
                        .background(isFollowed ? .white : Color(.systemBlue))
                        .foregroundColor(isFollowed ? .black : .white)
                        .cornerRadius(8)
                        
                }
                
                

            }
            
            
        }.padding(.horizontal)
    }
}
