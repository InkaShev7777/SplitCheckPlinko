//
//  UserCardCellView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import SwiftUI

struct UserCardCellView: View {
    @ObservedObject var user: User
    
    var body: some View {
        VStack {
            VStack {
                Text(user.userName)
                    .font(.system(size: 27))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 10)
                
                NavigationLink {
                    UserDetailsView(user: user)
                } label: {
                    VStack {
                        Image("button-more-info")
                            .frame(width: 194, height: 39)
                    }
                }
                
            }
            .frame(width: 313, height: 149)
            .background {
                Image("background-user-card")
                   
            }
            .cornerRadius(7.0)
            .tint(Color.black)
        }
    }
}

#Preview {
    UserCardCellView(user: User(userName: "Ilya"))
}
