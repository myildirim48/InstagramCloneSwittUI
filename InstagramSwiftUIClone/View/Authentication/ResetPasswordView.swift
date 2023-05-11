//
//  ResetPasswordView.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 4.05.2023.
//

import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var viewModel :  AuthViewModel
    @Binding var email: String
    @Environment(\.dismiss) var dismiss
    
    init(email: Binding<String>) {
        self._email = email
    }

    var body: some View {
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
                        .padding(.bottom)
                    
                    
                    VStack(spacing: 20) {
                        //                    email field
                        CustomTextField(text: $email, placeholder: Text("Email"), imgName: "envelope")
                    }.padding(.bottom,50)

                    //                    sig in
                    Button {
                        viewModel.resetPassword(withEmail: email)
                    } label: {
                        Text("Reset Password")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 50)
                            .background(.purple.opacity(0.7))
                            .clipShape(Capsule())
                    }
                    
                    
                    //                    go to sign up
                    
                    Spacer()
                    
                    Button {
                        dismiss()
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

        }.onReceive(viewModel.$didSendResetPasswordLink) { _ in
            dismiss()
        }
    }
    }


struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(email: .constant("emailadress"))
    }
}
