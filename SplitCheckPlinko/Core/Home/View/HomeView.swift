//
//  HomeView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import SwiftUI

struct HomeView: View {
    @State var usersList: [String] = ["Ilya", "Vlad", "Mark"]
    
    var body: some View {
        NavigationView {
            ZStack {
                if usersList.isEmpty {
                    EmptyHomeView()
                } else {
                    VStack {
                        ScrollView {
                            UserListView(usersList: $usersList)
                        }
                        .scrollIndicators(.hidden)
                    }
                }
                
                PlusButtonSubView()
            }
        }
    }
}

#Preview {
    HomeView()
}
