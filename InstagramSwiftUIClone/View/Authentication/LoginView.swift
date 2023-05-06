//
//  LoginView.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 4.05.2023.
//

import SwiftUI
import PhotosUI


struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.purple,Color.blue]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                    
                    VStack{
                        Image("instagram_logo")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .scaledToFit()
                            .frame(width: 220, height: 100)
                            .padding(.bottom,100)
                        
                        
                        VStack(spacing: 20) {
                            //                    email field
                            CustomTextField(text: $email, placeholder: Text("Email"), imgName: "envelope")
                            //                    password field
                            CustomTextField(text: $password, placeholder: Text("Password"), imgName: "lock",isSecure: true)
                            
                        }
                        
                        
                        //                    forgot password field
                        HStack {
                            Spacer()
                            
                            Button {
                                //                            Forgot password action
                            } label: {
                                Text("Forgot password?")
                                    .font(.system(size: 13,weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.trailing,28)
                                    .padding([.top,.bottom])
                            }
                        }
                        //                    sig in
                        Button {
                            viewModel.login(withEmail: email, password: password)
                        } label: {
                            Text("Sign In")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 360, height: 50)
                                .background(.purple.opacity(0.7))
                                .clipShape(Capsule())
                        }
                        
                        
                        //                    go to sign up
                        
                        Spacer()
                        
                        NavigationLink {
                            RegistrationView()
                                .navigationBarBackButtonHidden()
                        } label: {
                            HStack {
                                Text("Don't have an account?")
                                    .font(.system(size: 14))
                                
                                Text("Sign Up")
                                    .font(.system(size: 14,weight: .semibold))
                            }.foregroundColor(.white)
                                .padding(.bottom,10)
                        }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
