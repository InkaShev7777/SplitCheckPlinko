//
//  CalculatedUserCheckCellView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 16.12.2024.
//

import SwiftUI

struct CalculatedUserCheckCellView: View {
    @ObservedObject var user: User
    
    var body: some View {
        VStack {
            Text(user.userName)
                .font(.system(size: 27))
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
            
            Text(String(format: "%.2f$", user.totalPrice))
                .font(.system(size: 27))
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
                .padding(.bottom, 10)
            
            NavigationLink {
                UserDetailsView(user: user)
            } label: {
                VStack {
                    Image("button-order")
                        .frame(width: 194, height: 39)
                }
            }
            
        }
        .frame(width: UIScreen.main.bounds.width, height: 149)
        .background {
            Image("background-add-user-alert")
                .resizable()
                .frame(width: 313, height: 149)
               
        }
        .cornerRadius(7.0)
        .tint(Color.black)
    }
}

#Preview {
    CalculatedUserCheckCellView(user: User(userName: "Ilya"))
}
