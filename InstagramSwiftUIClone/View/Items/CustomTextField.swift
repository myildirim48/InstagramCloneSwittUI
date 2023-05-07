//
//  CustomTextField.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 4.05.2023.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    let placeholder: Text
    let imgName: String
    var isSecure: Bool = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundColor(Color(.init(white: 1, alpha: 0.8)))
                    .padding(.leading,40)
                    
            }
            HStack {
                Image(systemName: imgName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                
                if isSecure {
                    SecureField("", text: $text)
                }else{
                    TextField("", text: $text)
                }
                
            }
        }.padding()
            .background(Color(.init(white: 1, alpha: 0.15)))
            .cornerRadius(10)
            .padding(.horizontal,32)
            .foregroundColor(.white)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""), placeholder: Text("Placeholder"), imgName: "envelope")
    }
}
