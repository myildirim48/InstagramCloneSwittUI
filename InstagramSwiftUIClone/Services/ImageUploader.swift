//
//  ImageUploader.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 4.05.2023.
//

import SwiftUI
import FirebaseStorage

class ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        
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
