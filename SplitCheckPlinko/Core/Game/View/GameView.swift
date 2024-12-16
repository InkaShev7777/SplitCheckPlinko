//
//  GameView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 16.12.2024.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    var body: some View {
            GeometryReader { geometry in
                SpriteView(scene: makeScene(size: geometry.size))
                    .ignoresSafeArea() // Ensures the game fills the screen
            }
        }
        
        private func makeScene(size: CGSize) -> SKScene {
            let scene = GameScene(size: UIScreen.main.bounds.size, listOfUsers: HomeViewModel.shared.usersList)
//            scene.size = size
//            scene.scaleMode = .resizeFill
            return scene
        }
}

#Preview {
    GameView()
}
