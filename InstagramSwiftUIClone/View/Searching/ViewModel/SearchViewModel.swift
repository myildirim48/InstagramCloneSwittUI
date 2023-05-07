//
//  SearchViewModel.swift
//  InstagramSwiftUIClone
//
//  Created by YILDIRIM on 5.05.2023.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class SearchViewModel: ObservableObject {

    @Published var users = [User]()
    
    private let userService = UserService()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        userService.fetchUsers { users in
            self.users = users
        }
    }
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        return users.filter { $0.fullname.lowercased().contains(lowercasedQuery) || $0.username.lowercased().contains(query) }
    }

}
