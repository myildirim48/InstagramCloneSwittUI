//
//  NotificationCell.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 4.05.2023.
//

import SwiftUI

struct NotificationCell: View {
    
    @State var showPostImage = false
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            
            Text("joker")
                .font(.system(size: 14,weight: .bold))
            +
            Text(" liked one of your post")
                .font(.system(size: 14))
            
            Spacer()
            
            if showPostImage {
                Image("darth-vader")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 48)
                    .padding()
            }else {
                Button {
                    
                } label: {
                    Text("Following")
                        .padding(.horizontal,20)
                        .padding(.vertical,10)
                        .foregroundColor(.white)
                        .font(.system(size: 14,weight: .semibold))
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                        
                }
                
                

            }
            
            
        }.padding(.horizontal)
    }
}

struct NotificationCell_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCell()
    }
}
