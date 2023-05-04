//
//  ProfileHeaderView.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 4.05.2023.
//

import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("darth-vader")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .shadow(color: .gray.opacity(0.5), radius: 5)
                    .padding(10)
                Spacer()
                
                HStack(spacing: 6) {
                    UserStatView(title: "Posts", value: 1)
                    UserStatView(title: "Following", value: 13)
                    UserStatView(title: "Followers", value: 21)
                    
                }.padding(.trailing,24)
            }
            
            Text("Anakin Skywalker")
                .font(.system(size: 14,weight: .semibold))
                .padding([.leading,.top],10)
            
            Text("Dark side wants youu!!!")
                .font(.system(size: 15))
                .padding(.leading,10)
                .padding(.top,1)
            
            HStack {
                Spacer()
                ProfileActionButton()
                Spacer()
            }.padding(.top)

            
        }
    }
}


struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
    }
}
