//
//  UserStatView.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 4.05.2023.
//

import SwiftUI

struct UserStatView: View {
    let title: String
    let value: Int
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.system(size: 16,weight: .semibold))
            
            Text(title)
                .font(.system(size: 15))
        }.frame(width: 80, alignment: .center)
    }
}

struct UserStatView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatView(title: "Followers", value: 2)
    }
}
