//
//  GameScene.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 16.12.2024.
//

import Foundation
import SpriteKit

import Foundation
import SpriteKit
import SwiftUI

class GameScene: SKScene, SKPhysicsContactDelegate {
    var listOfUsers: [User]
    
    let ballCategory: UInt32 = 0x1 << 0
    let slotCategory: UInt32 = 0x1 << 1
    
    init(size: CGSize, listOfUsers: [User]) {
        self.listOfUsers = listOfUsers
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background-game")
        
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        background.size = self.size
        
        background.zPosition = -1
        
        addChild(background)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        self.physicsWorld.contactDelegate = self
        
        let numRows = 7
        let pegSpacing: CGFloat = 62

        for row in 2 ..< numRows {
            let numPegs =  row + 1
            
            for col in 0 ..< numPegs {
                let xOffset = frame.midX - CGFloat(numPegs - 1) * pegSpacing / 2
                let peg = SKShapeNode(circleOfRadius: 8)
                peg.strokeColor = .white
                peg.fillColor = .gray
                peg.position = CGPoint(
                    x: xOffset + CGFloat(col) * pegSpacing,
                    y: frame.height - CGFloat(row + 1) * pegSpacing * 1.2
                )
                peg.physicsBody = SKPhysicsBody(circleOfRadius: 8)
                peg.physicsBody?.isDynamic = false
                addChild(peg)
            }
        }
        
        let screenWidth = frame.width
        let tileHeight: CGFloat = 20
        let tileWidth = screenWidth / CGFloat(listOfUsers.count)
        let tileYPosition: CGFloat = 50
        
        for (index, user) in listOfUsers.enumerated() {
            
            let slot = SKShapeNode(rectOf: CGSize(width: tileWidth, height: tileHeight))
            slot.fillColor = .green
            slot.position = CGPoint(
                x: tileWidth / 2 + CGFloat(index) * tileWidth,
                y: tileYPosition
            )
            slot.name = user.userName
            slot.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: tileWidth, height: tileHeight))
            slot.physicsBody?.isDynamic = false
            slot.physicsBody?.categoryBitMask = slotCategory
            slot.physicsBody?.contactTestBitMask = ballCategory
            addChild(slot)
            
            let userLabel = SKLabelNode(text: user.userName)
            userLabel.fontColor = .black
            userLabel.fontSize = 12
            userLabel.verticalAlignmentMode = .center
            userLabel.position = CGPoint(
                x: slot.position.x,
                y: slot.position.y + tileHeight
            )
            addChild(userLabel)
        }
    }
    
    func dropBall(at position: CGPoint) {
        let ball = SKShapeNode(circleOfRadius: 15)
        ball.fillColor = .red
        ball.position = position
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 15)
        ball.physicsBody?.restitution = 0.6
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = slotCategory
        addChild(ball)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if location.y > frame.height * 0.8 {
            dropBall(at: CGPoint(x: location.x, y: frame.height - 50))
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA.node
        let bodyB = contact.bodyB.node
        
        let ballNode = (bodyA?.name == nil ? bodyA : bodyB)
        let slotNodeName = bodyA?.name ?? bodyB?.name

        if let ballNode = ballNode, let slotNodeName = slotNodeName {
            if ballNode.userData == nil {
                ballNode.userData = NSMutableDictionary()
            }
            
            if ballNode.userData?["alertShown"] as? Bool == true {
                return
            }
            
            ballNode.userData?["alertShown"] = true
            
            showAlert(for: slotNodeName, ballNode: ballNode)
        }
    }
    
    func showAlert(for userName: String, ballNode: SKNode) {
        DispatchQueue.main.async {
            guard let view = self.view else { return }
            
            var totalPrice = 0.0
            for user in self.listOfUsers {
                totalPrice += user.totalPrice
            }
            
            let alertView = CustomPayAlertView(userName: userName, totalPrice: totalPrice)
            
            let hostingController = UIHostingController(rootView: alertView)
            hostingController.modalPresentationStyle = .overFullScreen
            hostingController.modalTransitionStyle = .crossDissolve
            
            if let viewController = view.window?.rootViewController {
                viewController.present(hostingController, animated: true)
            }
        }
    }
}
