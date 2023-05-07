//
//  ContentView.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 3.05.2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    @State var selectedIndex = 0
    
    var body: some View {
        Group {
            if authViewModel.userSessions == nil {
                LoginView()
            }else {
                if let user = authViewModel.currentUser {
                    MainTabView(selectedIndex: $selectedIndex, user: user)
                }
                }
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
         
    }
}
