//
//  SearchBar.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 4.05.2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    @FocusState private var searchIsFocused: Bool
    
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(8)
                .padding(.horizontal,24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .focused($searchIsFocused)
                .overlay {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
                            .padding(.leading,6)
                }
                }
                .onTapGesture {
                    withAnimation {
                        isEditing = true
                        searchIsFocused = true
                    }
                }
            
            if isEditing {
                Button {
                    withAnimation {
                        isEditing = false
                        searchIsFocused = false
                        text = ""
                    }
                    
                } label: {
                    Text("Cancel")
                }
                .padding(.trailing,8)
                .transition(.move(edge: .trailing))


            }
        }.padding(.horizontal)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Text"), isEditing: .constant(false))
    }
}
