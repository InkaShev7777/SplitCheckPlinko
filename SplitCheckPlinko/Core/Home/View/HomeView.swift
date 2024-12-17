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
                
                if isShowAlert {
                    CustomAlertAddUserView(isShowAlert: $isShowAlert)
                }
                
                VStack {
                    VStack {
                        HeaderView()

                        if viewModel.usersList.isEmpty {
                            EmptyHomeView(isShowAlert: $isShowAlert)
                        } else {
                            ScrollView {
                                UserListView(usersList: $viewModel.usersList, isShowPlusButton: $isShowPlusButton)
                            }
                            .frame(height: 600)
                            .frame(maxHeight: .infinity)
                            .scrollIndicators(.hidden)
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
            }
        }
    }
}

#Preview {
    HomeView()
}
