//
//  SearchView.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 3.05.2023.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @State var inSearchMode = false
    
    @ObservedObject var viewModel =  SearchViewModel()
    
    var body: some View {
        ScrollView {
//            search bar
            SearchBar(text: $searchText, isEditing: $inSearchMode)
                .padding()
            
            ZStack {
                if inSearchMode {
                    UserListView(viewModel: viewModel,searchText: $searchText)
                }else {
                    PostGridView(config: .explore)
                }
            }
        }
    }
}
