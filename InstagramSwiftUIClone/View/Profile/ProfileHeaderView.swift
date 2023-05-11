//
//  ProfileHeaderView.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 4.05.2023.
//

import SwiftUI

struct ProfileHeaderView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                LoadableImage(imageType: .profile,imgUrl: viewModel.user.profileImageurl,size: 80)
                    .shadow(color: .gray.opacity(0.5), radius: 5)
                    .padding(10)
                Spacer()
                
                HStack(spacing: 6) {
                    
                    UserStatView(title: "Posts", value: viewModel.user.stats?.posts ?? 0)
                    UserStatView(title: "Following", value: viewModel.user.stats?.following ?? 0)
                    UserStatView(title: "Followers", value: viewModel.user.stats?.followers ?? 0)
                    
                }.padding(.trailing,24)
            }
            
            Text(viewModel.user.fullname)
                .font(.system(size: 14,weight: .semibold))
                .padding([.leading,.top],10)
            
            if let bio = viewModel.user.bio {
                Text(bio)
                    .font(.system(size: 15))
                    .padding(.leading,10)
                    .padding(.top,1)
            }
            
            HStack {
                Spacer()
                ProfileActionButton(viewModel: viewModel)
                Spacer()
            }.padding(.top)
            
            
        }
    }
}
