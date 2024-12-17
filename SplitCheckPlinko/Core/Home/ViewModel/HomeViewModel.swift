//
//  HomeViewModel.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    static let shared = HomeViewModel()
    
    @Published var usersList: [User] = []
    
    init() {
        getCoreData()
    }
    
    public func getCoreData() {
        usersList = CoreDataManager.shared.fetchUsers()
    }
    
    func addNewUser(name: String) {
        
    }
    
    func deleteUser(user: User) {
        CoreDataManager.shared.deleteUser(user: user)
        getCoreData()
    }
    
    func currentDateFormatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE dd"
        return formatter.string(from: Date())
    }
}
