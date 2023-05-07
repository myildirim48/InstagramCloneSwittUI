//
//  ImageUploader.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 4.05.2023.
//

import SwiftUI
import FirebaseStorage

enum UploadType {
    case profile
    case post
    
    var filePath: StorageReference {
        let fileName = NSUUID().uuidString
        switch self {
        case .profile:
            return Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        case .post:
            return Storage.storage().reference(withPath: "/post_images/\(fileName)")
        }
    }
}

class ImageUploader {
    static func uploadImage(image: UIImage, type: UploadType, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let ref = type.filePath
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error {
                print("DEBUG: Failed to upload image with error : \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { imgUrl, _ in
                guard let imgUrl = imgUrl?.absoluteString else { return }
                completion(imgUrl)
            }
        }
    }
}
