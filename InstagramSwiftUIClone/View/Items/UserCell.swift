//
//  UserCell.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 4.05.2023.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 48, height: 48, alignment: .leading)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("Name")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                
                Text("namesurname")
                    .font(.system(size: 14, weight: .light, design: .rounded))
                
            }
            Spacer()
        }
        .padding(.leading)
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell()
    }
}
