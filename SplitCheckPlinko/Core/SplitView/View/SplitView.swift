//
//  SplitView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 16.12.2024.
//

import SwiftUI

struct SplitView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = HomeViewModel.shared
    @State var totalAmount: Double = 0.0
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView()
                
                VStack {
                    ScrollView {
                        ForEach(viewModel.usersList){ user in
                            if user.totalPrice > 0 {
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
                    .padding(.bottom, -35)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Image("back-button")
                            .resizable()
                            .frame(width: 38, height: 40)
                    }
                }
            }
            .background {
                Image("background")
                    .ignoresSafeArea()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SplitView()
}
