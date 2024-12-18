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
            HeaderView()
            
            VStack {
                VStack {
                    ScrollView {
                        ForEach(viewModel.usersList){ user in
                            CalculatedUserCheckCellView(user: user)
                        }
                    }
                }
                
                VStack {
                    NavigationLink {
                        GameView()
                    } label: {
                        Image("button-game")
                    }
                }
            }
        }
//        .navigationBarBackButtonHidden()
//        .padding(.top, 45)
//        .ignoresSafeArea()
        .background {
            Image("background")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    SplitView()
}
