//
//  PostGridView.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 4.05.2023.
//

import SwiftUI

struct PostGridView: View {
    private let items = [GridItem(),GridItem(),GridItem()]
    private let width = UIScreen.main.bounds.width / 3.3
    var body: some View {
        LazyVGrid(columns: items,spacing: 4) {
            ForEach(0..<10) { _ in
                NavigationLink {
                    FeedView()
                } label: {
                    
                    Image("darth-vader")
                        .resizable()
                        .scaledToFill()
                        .frame(width: width)
                }

            }
        }
    }
}

struct PostGridView_Previews: PreviewProvider {
    static var previews: some View {
        PostGridView()
    }
}
