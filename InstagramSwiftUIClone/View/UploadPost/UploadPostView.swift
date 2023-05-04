//
//  UploadPostView.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 3.05.2023.
//

import SwiftUI
import PhotosUI


struct UploadPostView: View {
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @State var selectedImageData: Data?
    @State var captionText = ""
    
    var body: some View {
        VStack {
            if selectedImageData == nil {
                PhotosPicker(selection: $selectedItems,
                             maxSelectionCount: 1,
                             matching: .images) {
                    
                    Image(systemName: "person.crop.rectangle.badge.plus")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 125, height: 125)
                        .padding(.top,50)
                    
                }.onChange(of: selectedItems) { item in
                    guard let item = selectedItems.first else { return }
                    item.loadTransferable(type: Data.self) { result in
                        switch result {
                        case .success(let data):
                            if let data {
                                self.selectedImageData = data
                            }else {
                                print("DEBUG : Profile photo is nil.")
                                
                            }
                        case .failure(let error):
                            fatalError("Fatal error at profile photo error: \(error.localizedDescription)")
                        }
                    }
                }
            }else if let selectedImageData, let uiimage = UIImage(data: selectedImageData) {
                
                HStack(alignment: .top) {
                Image(uiImage: uiimage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 96, height: 96)
                        .clipped()
                    
                    TextField("Caption...", text: $captionText)
                }.padding()
                
                Button {
                    
                } label: {
                    Text("Share")
                        .font(.system(size: 16,weight: .semibold))
                        .frame(width: 360, height: 50)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }.padding()

                
            }
            
            Spacer()
            
            
        }
        
    }
}

struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView()
    }
}
