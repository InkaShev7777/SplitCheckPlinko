//
//  HomeView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import SwiftUI

struct HomeView: View {
    @State var isShowAlert: Bool = false
    @State var newUserName: String = ""
    @State var isShowPlusButton: Bool = true
    @StateObject var viewModel = HomeViewModel.shared
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    HeaderView()
                    
                    if viewModel.usersList.isEmpty {
                        EmptyHomeView(isShowAlert: $isShowAlert)
                    } else {
                        VStack {
                            ScrollView {
                                UserListView(usersList: $viewModel.usersList, isShowPlusButton: $isShowPlusButton)
                            }
                            .frame(maxHeight: .infinity)
                            .scrollIndicators(.hidden)
                        }
                    }
                }
                
                if !viewModel.usersList.isEmpty {
                    HStack {
                        CalculateButtonSubView()
                            .padding(.leading)
                        PlusButtonSubView(isShowAlert: $isShowAlert)
                    }
                }
            }
            .alert("Add New User", isPresented: $isShowAlert) {
                TextField("Enter the user name...", text: $newUserName)
                
                Button("Cancel", role: .cancel) {
                    withAnimation {
                        isShowAlert.toggle()
                        newUserName = ""
                    }
                }
                
                Button("OK") {
                    withAnimation {
                        if !newUserName.isEmpty {
                            CoreDataManager.shared.addUser(user: User(userName: newUserName))
                            viewModel.getCoreData()
                        }
                        newUserName = ""
                        isShowAlert = false
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
