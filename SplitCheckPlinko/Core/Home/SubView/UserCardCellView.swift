//
//  UserCardCellView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import SwiftUI

struct UserCardCellView: View {
    @State var user: User
    @State var showDeleteAlert: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                Text(user.userName)
                    .font(.title)
                    .fontWeight(.semibold)
                
                NavigationLink {
                    withAnimation {
                        UserDetailsView(user: user)
                    }
                } label: {
                    Text("More Info")
                }
                .padding(.top, 1)
            }
            .frame(width: 250, height: 200)
            .background(Color.gray)
            .cornerRadius(7.0)
        }
        .onLongPressGesture {
            showDeleteAlert = true
        }
        .alert("Delete \(user.userName)", isPresented: $showDeleteAlert) {
            
            Button("Cancel", role: .cancel) {
                withAnimation {
                    showDeleteAlert = false
                }
            }
            
            Button("OK") {
                withAnimation {
                    HomeViewModel.shared.deleteUser(user: user)
                    showDeleteAlert = false
                }
            }
        }
    }
}

//#Preview {
//    UserCardCellView(userName: "Ilya")
//}
