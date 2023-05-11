//
//  LoadableImage.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 5.05.2023.
//

import SwiftUI

enum imageType {
    case profile
    case post
    
    var baseImageName: String {
        switch self {
        case .profile:
            return "person.circle.fill"
        case .post:
            return "photo"
        }
    }
}
struct LoadableImage: View {
    
    let imageType: imageType
    
    let imgUrl: String
    
    var size: CGFloat = 54
    
    var body: some View {
            AsyncImage(url: URL(string: imgUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    
                    switch imageType {
                    case .profile:
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: size, height: size)
                            .clipShape(Circle())
                            .shadow(color: .gray.opacity(0.5), radius: 5)
                        
                    case .post:
                        image
                            .resizable()
                            .scaledToFill()
//                            .frame(maxHeight: 440)
//                            .shadow(color: .gray.opacity(0.5), radius: 5)
                    }
     
                case .failure:
                    emptyImage
                @unknown default:
                    emptyImage
                }
            }

    }
}

struct LoadableImage_Previews: PreviewProvider {
    static var previews: some View {
        LoadableImage(imageType: .post, imgUrl: "asd")
    }
}

extension LoadableImage {
    var emptyImage: some View {
        Image(systemName: imageType.baseImageName)
            .resizable()
            .scaledToFill()
            .frame(width: 48, height: 48)
            .clipShape(Circle())
            .shadow(color: .gray.opacity(0.5), radius: 5)
    }
    
}
