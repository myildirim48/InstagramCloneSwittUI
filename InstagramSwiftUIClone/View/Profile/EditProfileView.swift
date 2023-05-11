//
//  EditProfileView.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 11.05.2023.
//

import SwiftUI

struct EditProfileView: View {
    @State private var bioText: String

    @ObservedObject private var viewModel: EditProfileViewModel
    @Environment(\.dismiss) var dissmis
    @Binding var user: User
    
    init(user: Binding<User>) {
        self._user = user
        self.viewModel = EditProfileViewModel(user: self._user.wrappedValue)
        self._bioText = State(initialValue: _user.wrappedValue.bio ?? "")
    }
    
    
    var body: some View {
            VStack {
                HStack {
                    Button {
                        dissmis()
                    } label: {
                        Text("Cancel")
                            .bold()
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.saveUserData(bioText)
                    } label: {
                        Text("Done")
                            .bold()
                    }
                }.padding()
                
                
                TextArea(placeholder: "Add your bio.", text: $bioText)
                    .frame(width: 370, height: 100, alignment: .topLeading)
                    .padding()
                Spacer()
            }.onReceive(viewModel.$uploadCompleted) { completed in
                
                if completed {
                    self.user.bio = bioText

                    dissmis()
                }
                
            }
    }
}
