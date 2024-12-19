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
                VStack {
                    HeaderView()
                    
                    Spacer()
                }
                
                if isShowAlert {
                    CustomAlertAddUserView(isShowAlert: $isShowAlert)
                        .zIndex(10)
                }
                
                VStack {
                    if viewModel.usersList.isEmpty {
                        if !isShowAlert {
                            EmptyHomeView(isShowAlert: $isShowAlert)
                        }
                    } else {
                        ScrollView {
                            UserListView(usersList: $viewModel.usersList, isShowPlusButton: $isShowPlusButton)
                        }
                        .frame(height: UIScreen.main.bounds.height / 1.4)
                        .scrollIndicators(.hidden)
                    }
                    
                    if !viewModel.usersList.isEmpty {
                        HStack {
                            CalculateButtonSubView()
                                .padding(.leading)
                            PlusButtonSubView(isShowAlert: $isShowAlert)
                        }
                    }
                }
                .padding(.top, 80)
            }
            .background {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
            }
        }
    }
}

#Preview {
    HomeView()
}
