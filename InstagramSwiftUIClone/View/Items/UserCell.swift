//
//  UserCell.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 4.05.2023.
//

import SwiftUI

struct UserCell: View {
    
    let user: User
    
    var body: some View {
        HStack {
            LoadableImage(imgUrl: user.profileImageurl,size: 48)
            
            VStack(alignment: .leading) {
                Text(user.fullname)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                
                Text(user.username)
                    .font(.system(size: 14, weight: .light, design: .rounded))
                
            }
            Spacer()
        }
        .padding(.leading)
    }
}

//struct UserCell_Previews: PreviewProvider {
//    static var previews: some View {
//        UserCell()
//    }
//}
