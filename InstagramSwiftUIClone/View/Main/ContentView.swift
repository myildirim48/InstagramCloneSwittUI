//
//  ContentView.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 3.05.2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel

    var body: some View {
        Group {
            if authViewModel.userSessions == nil {
                LoginView()
            }else {
                if let user = authViewModel.currentUser {
                    MainTabView(user: user)
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
