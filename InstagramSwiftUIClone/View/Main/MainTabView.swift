//
//  MainTabView.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 3.05.2023.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dissmis
    
    let user: User
    
    var body: some View {
        NavigationView {
            TabView {
                FeedView()
                    .tabItem {
                        Image(systemName: "house")
                    }
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                
                UploadPostView()
                    .tabItem {
                        Image(systemName: "plus.app")
                    }
                
                NotificationsView()
                    .tabItem {
                        Image(systemName: "heart")
                    }
                
                ProfileView(user: user)
                    .tabItem {
                        Image(systemName: "person")
                    }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    logOutButton
                }
            }

        }
    }
    
    var logOutButton: some View {
        Button {
            authViewModel.logOut()
            dissmis()
        } label: {
            Text("Logout")
                .font(.system(size: 14,weight: .semibold))
            
        }

    }
}

