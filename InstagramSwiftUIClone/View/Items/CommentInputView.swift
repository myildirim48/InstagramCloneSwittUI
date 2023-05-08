//
//  CommentInputView.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 7.05.2023.
//

import SwiftUI

struct CommentInputView: View {
    
    @Binding var inputText: String
    
    var action: () -> Void
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(height: 0.75)
                .padding(.bottom)
            HStack {
                TextField("Comment..", text: $inputText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(minHeight: 30)
                
                
                Button(action: action) {
                    Text("Send")
                        .bold()
                        .foregroundColor(.blue)
                }

            }.padding(.horizontal)
                .padding(.bottom,8)
        }
    }
}

struct CommentInputView_Previews: PreviewProvider {
    static var previews: some View {
        CommentInputView(inputText: .constant("asd")) {
            
        }
    }
}
