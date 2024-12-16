//
//  SplitView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 16.12.2024.
//

import SwiftUI

struct SplitView: View {
    @StateObject var viewModel = HomeViewModel.shared
    @State var totalAmount: Double = 0.0
    var body: some View {
        VStack {
            HStack {
                Text("Total Amount:")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("\(String(format: "%.2f", totalAmount))$")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
            Divider()
            
            ScrollView {
                ForEach(viewModel.usersList){ user in
                    NavigationLink {
                        withAnimation {
                            UserDetailsView(user: user)
                        }
                    } label: {
                        CalculatedUserCheckCellView(userName: user.userName, totalPrice: user.totalPrice)
                            .tint(Color.black)
                    }
                }
            }
            
            ZStack {
                NavigationLink {
                    
                } label: {
                    Text("Try Your Luck")
                        .font(.title2)
                        .foregroundStyle(Color.white)
                        .frame(width: 170, height: 50)
                        .background(Color.blue)
                        .cornerRadius(8.0)
                }
                .padding()
            }
        }
        .onAppear {
            totalAmount = viewModel.usersList.reduce(0) { $0 + $1.totalPrice }
        }
    }
}

#Preview {
    SplitView()
}
