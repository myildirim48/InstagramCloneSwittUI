//
//  RegistrationView.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 4.05.2023.
//

import SwiftUI
import PhotosUI

struct RegistrationView: View {
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var email = ""
    
    
    @State var selectedImageData: Data?
    @State var selectedImage: UIImage? = nil
    @State private var selectedItems: [PhotosPickerItem] = []
    @EnvironmentObject var viewModel :  AuthViewModel

    @Environment(\.dismiss) var dissmis
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.purple,Color.blue]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                if selectedImageData == nil {
                    
                    VStack {
                        PhotosPicker(selection: $selectedItems,
                                     maxSelectionCount: 1,
                                     matching: .images) {
                            Image(systemName: "person.crop.rectangle.badge.plus")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 125, height: 125)
                                .padding(.top,50)
                                .foregroundColor(.white)
                        }
                        
                        
                        
                    }.onChange(of: selectedItems) { item in
                        guard let item = selectedItems.first else { return }
                        item.loadTransferable(type: Data.self) { result in
                            switch result {
                            case .success(let data):
                                if let data {
                                    self.selectedImageData = data
                                    self.selectedImage = UIImage(data: data)
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
                            .frame(width: 125, height: 125)
                            .clipShape(Circle())
                            .shadow(color: .gray.opacity(0.5), radius: 5)
                    }
                }
                
                    
                    
                
                        
                        VStack(spacing: 20) {
                            
                            CustomTextField(text: $email, placeholder: Text("Email"), imgName: "envelope")
                            
                            CustomTextField(text: $username, placeholder: Text("Username"), imgName: "person")
                            
                            CustomTextField(text: $fullname, placeholder: Text("Full Name"), imgName: "person")
                            
                            CustomTextField(text: $password, placeholder: Text("Password"), imgName: "lock",isSecure: true)
                            
                            
                            Button {
                                viewModel.register(withEmail: email,
                                                   password: password,
                                                   image: selectedImage,
                                                   fullname: fullname,
                                                   username: username)
                            } label: {
                                
                                Text("Sign Up")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(width: 360, height: 50)
                                    .background(.purple.opacity(0.7))
                                    .clipShape(Capsule())
                            }
                        }
                        
                        Spacer()
                        
                        NavigationLink {
                            LoginView()
                        } label: {
                            HStack {
                                Text("Already you have an account?")
                                    .font(.system(size: 14))
                                
                                Text("Sign In")
                                    .font(.system(size: 14,weight: .semibold))
                            }.foregroundColor(.white)
                                .padding(.bottom,10)
                        }
                    }
                
            }
            
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
