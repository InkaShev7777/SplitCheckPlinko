//
//  CustomDeleteUserAlert.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 18.12.2024.
//

import SwiftUI

struct CustomDeleteUserAlert: View {
    @Binding var isShowDeleteAlert: Bool
    var user: User
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Do you want to delete User: ")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .padding(.trailing, -5)
                    
                    Text("\(user.userName)")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                }
                .foregroundStyle(.white)
                
                HStack {
                    Button {
                        isShowDeleteAlert = false
                    } label: {
                        Image("purple-cancel-button")
                            .frame(width: 150,height: 60)
                    }
                    
                    Button {
                        HomeViewModel.shared.deleteUser(user: user)
                    } label: {
                        Image("red-button-delete")
                            .frame(width: 150,height: 60)
                    }
                }
                .padding(.top, 35)
                .padding(.horizontal)
            }
        }
        .zIndex(10)
        .background {
            Image("background-add-user-alert")
        }
    }
}

//#Preview {
//    CustomDeleteUserAlert()
//}
