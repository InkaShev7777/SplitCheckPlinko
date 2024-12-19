//
//  GameView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 16.12.2024.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var selectedUser: String = ""
    @State var totalPrice: Double = 0.0
    
    @State var showWinerAlert: Bool = false
    var body: some View {
        ZStack {
            if showWinerAlert {
                CustomPayAlertView(showWinderAlert: $showWinerAlert, userName: selectedUser, totalPrice: totalPrice)
                    .zIndex(10)
            }
            GeometryReader { geometry in
                SpriteView(scene: makeScene(size: geometry.size))
                    .ignoresSafeArea()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    //action
                    dismiss()
                } label: {
                    Image("back-button")
                }
            }
        }
        .navigationBarBackButtonHidden()
        
    }
    
    private func makeScene(size: CGSize) -> SKScene {
        let scene = GameScene(size: UIScreen.main.bounds.size, listOfUsers: HomeViewModel.shared.usersList, selectedUserName: $selectedUser, totalPrice: $totalPrice, showWinderAlert: $showWinerAlert)
        return scene
    }
}

#Preview {
    GameView()
}
