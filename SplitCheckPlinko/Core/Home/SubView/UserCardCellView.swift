//
//  UserCardCellView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import SwiftUI

struct UserCardCellView: View {
    @Binding var isShowPlusButton: Bool
    @State var user: User
    
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
//        NavigationView {
//
//        }
    }
}

//#Preview {
//    UserCardCellView(userName: "Ilya")
//}
