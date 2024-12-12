//
//  HomeView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel.shared
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.usersList.isEmpty {
                    EmptyHomeView()
                } else {
                    VStack {
                        ScrollView {
                            UserListView(usersList: $viewModel.usersList)
                        }
                        .scrollIndicators(.hidden)
                    }
                    
                    PlusButtonSubView()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
