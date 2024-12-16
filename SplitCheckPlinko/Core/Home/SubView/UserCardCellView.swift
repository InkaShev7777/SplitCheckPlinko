//
//  UserCardCellView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import SwiftUI

struct UserCardCellView: View {
    @State var user: User
    
    var body: some View {
        VStack {
            NavigationLink {
                UserDetailsView(user: user)
            } label: {
                VStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(Color.black)
                    
                    Text(user.userName)
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .frame(width: 250, height: 200)
                .background(Color.gray)
                .cornerRadius(7.0)
                .tint(Color.black)
            }
        }
    }
}

//#Preview {
//    UserCardCellView(userName: "Ilya")
//}
