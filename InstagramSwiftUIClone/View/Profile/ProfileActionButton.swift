//
//  ProfileActionButton.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 4.05.2023.
//

import SwiftUI

struct ProfileActionButton: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State var editProfile = false
    
    var isFollowing: Bool { return viewModel.user.isFollowed ?? false}
    
    
    var body: some View {
        if viewModel.user.isCurrentUser {
            Button {
                editProfile.toggle()
            } label: {
                Text("Edit profile")
                    .font(.system(size: 15,weight: .semibold))
                    .frame(width: 350, height: 32, alignment: .center)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.gray, lineWidth:1)
                    })
            }.sheet(isPresented: $editProfile) {
                EditProfileView(user: $viewModel.user)
            }
        }else {
            
            HStack {
                Button {
                    isFollowing ? viewModel.unfollow() : viewModel.follow()
                } label: {
                    Text(isFollowing ? "Following" : "Follow")
                        .font(.system(size: 15,weight: .semibold))
                        .frame(width: 172, height: 32, alignment: .center)
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: isFollowing ? 1 : 0)
                        })
                        .background(isFollowing ? .white : Color(.systemBlue))
                        .foregroundColor(isFollowing ? .black : .white)
            }
            
            
            Button {
                
            } label: {
                Text("Message")
                    .font(.system(size: 15,weight: .semibold))
                    .frame(width: 172, height: 32, alignment: .center)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.gray, lineWidth:1)
                    })
        }
            }
        }
    }
}
