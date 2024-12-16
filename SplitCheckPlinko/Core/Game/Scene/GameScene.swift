//
//  GameScene.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 16.12.2024.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
            // Set up the physics world
            self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
            self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
            
            // Add pegs
            for i in 0..<5 {
                for j in 0..<5 {
                    let peg = SKSpriteNode(color: .blue, size: CGSize(width: 20, height: 20))
                    peg.position = CGPoint(x: CGFloat(i) * 100 + 50, y: CGFloat(j) * 100 + 300)
                    peg.physicsBody = SKPhysicsBody(circleOfRadius: 10)
                    peg.physicsBody?.isDynamic = false
                    addChild(peg)
                }
            }
            
            // Add slots at the bottom
            for i in 0..<5 {
                let slot = SKSpriteNode(color: .green, size: CGSize(width: 100, height: 20))
                slot.position = CGPoint(x: CGFloat(i) * 100 + 50, y: 50)
                slot.physicsBody = SKPhysicsBody(rectangleOf: slot.size)
                slot.physicsBody?.isDynamic = false
                addChild(slot)
            }
        }
        
        func dropBall(at position: CGPoint) {
            let ball = SKSpriteNode(color: .red, size: CGSize(width: 30, height: 30))
            ball.position = position
            ball.physicsBody = SKPhysicsBody(circleOfRadius: 15)
            ball.physicsBody?.restitution = 0.5
            ball.physicsBody?.isDynamic = true
            addChild(ball)
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let touch = touches.first {
                let location = touch.location(in: self)
                dropBall(at: location)
                print("DEBUG: Touch")
            }
        }
}
