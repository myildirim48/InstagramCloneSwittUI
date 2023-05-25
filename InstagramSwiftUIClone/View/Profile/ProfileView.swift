//
//  ProfileView.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 3.05.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    
    let user: User
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                ProfileHeaderView(viewModel: viewModel)
                Divider()
                PostGridView(config: .profile(user.id ?? ""))
                
            }
        }
    }
}
