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
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        COLLECTION_USERS
            .getDocuments { snapshot, err in
                
                if let err {
                    print("DEBUG : Error \(err.localizedDescription)")
                }
                guard let document = snapshot?.documents else { return }
                self.users = document.compactMap { try? $0.data(as: User.self) }
                print("DEBUG : users search \(self.users)")
            }
    }
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        
        return users.filter { $0.fullname.lowercased().contains(lowercasedQuery) || $0.username.lowercased().contains(query) }
    }
}
