//
//  CustomAlertAddUserView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 17.12.2024.
//

import SwiftUI

struct CustomAlertAddUserView: View {
    @StateObject var viewModel = HomeViewModel.shared
    @State var userName: String = ""
    @Binding var isShowAlert: Bool
    
    var body: some View {
        ZStack {
            Image("background-add-user-alert")
            
            VStack {
                Text("Enter user`s name: ")
                    .font(.system(size: 19))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 0)
                
                TextField("", text: $userName)
                    .font(.system(size: 22))
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .frame(width: 150, height: 40)
                    .tint(Color.white)
                    .foregroundStyle(Color.white)
                    .background {
                        Image("background-text-field")
                    }
                
                HStack {
                    Button {
                        // action cancel
                        withAnimation {
                            isShowAlert = false
                            userName = ""
                        }
                    } label: {
                        Image("button-cancel")
                            .frame(width: 150, height: 50)
                    }
                    
                    Button {
                        withAnimation {
                            isShowAlert = false
                            if !userName.isEmpty {
                                CoreDataManager.shared.addUser(user: User(userName: userName))
                                viewModel.getCoreData()
                            }
                        }
                        // action ok
                    } label: {
                        Image("button-save")
                            .frame(width: 150, height: 50)
                    }
                }
                .padding(.top, 40)
            }
        }
        .zIndex(10)
    }
}

//#Preview {
//    CustomAlertAddUserView(isShowAlert: true)
//}
