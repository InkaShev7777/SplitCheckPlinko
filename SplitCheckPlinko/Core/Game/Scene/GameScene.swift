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
    
    @Binding var selectedUserName: String
    @Binding var totalPrice: Double
    @Binding var showWinderAlert: Bool
    
    let ballCategory: UInt32 = 0x1 << 0
    let slotCategory: UInt32 = 0x1 << 1
    
    init(size: CGSize, listOfUsers: [User], selectedUserName: Binding<String>, totalPrice: Binding<Double>, showWinderAlert: Binding<Bool>) {
        self.listOfUsers = listOfUsers
        self._selectedUserName = selectedUserName
        self._totalPrice = totalPrice
        self._showWinderAlert = showWinderAlert
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        // background
        let background = SKSpriteNode(imageNamed: "background-game")
        
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        background.size = self.size
        
        background.zPosition = -1
        
        addChild(background)
        
        // list plinko ball
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        self.physicsWorld.contactDelegate = self
        
        let pegSpacing: CGFloat = (size.width / 7) - 12
        let totalRows = 9
        let ballsInOddRow = 9
        let ballsInEvenRow = 8
        
        let totalHeight = CGFloat(totalRows) * pegSpacing * 1.2
        
        let verticalOffset = (frame.height - totalHeight) / 2
        
        for row in 0 ..< totalRows {
            let numPegs = (row % 2 == 0) ? ballsInOddRow : ballsInEvenRow
            
            for col in 0 ..< numPegs {
                let xOffset = frame.midX - CGFloat(numPegs - 1) * pegSpacing / 2
                
                let pegNode = SKNode()
                
                let backgroundCircle = SKShapeNode(circleOfRadius: 10)
                backgroundCircle.fillColor = SKColor(red: 0.0, green: 0.231, blue: 0.988, alpha: 1.0)
                backgroundCircle.strokeColor = .clear
                pegNode.addChild(backgroundCircle)
                
                pegNode.position = CGPoint(
                    x: xOffset + CGFloat(col) * pegSpacing,
                    y: verticalOffset + CGFloat(row) * pegSpacing * 1.2
                )
                
                let physicsBody = SKPhysicsBody(circleOfRadius: 10)
                physicsBody.isDynamic = false
                pegNode.physicsBody = physicsBody
                
                addChild(pegNode)
            }
        }
        
        let screenWidth = frame.width
        let tileHeight: CGFloat = 20
        let tileWidth = screenWidth / CGFloat(listOfUsers.count)
        let tileYPosition: CGFloat = 50
        
        // bottom buttons with user name
        for (index, user) in listOfUsers.enumerated() {
            let slot = SKNode()
            slot.position = CGPoint(
                x: tileWidth / 2 + CGFloat(index) * tileWidth,
                y: tileYPosition
            )
            slot.name = user.userName
            
            let background = SKSpriteNode(texture: SKTexture(imageNamed: "background-button-plinko-user"))
            background.size = CGSize(width: tileWidth - 10, height: 59)
            background.position = .zero
            slot.addChild(background)
            
            slot.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: tileWidth, height: tileHeight))
            slot.physicsBody?.isDynamic = false
            slot.physicsBody?.categoryBitMask = slotCategory
            slot.physicsBody?.contactTestBitMask = ballCategory
            
            let userLabel = SKLabelNode(text: user.userName)
            userLabel.fontColor = .white
            userLabel.fontSize = 17
            userLabel.fontName = "Helvetica-Bold"
            userLabel.verticalAlignmentMode = .center
            userLabel.position = .zero
            slot.addChild(userLabel)
            
            addChild(slot)
        }
        
    }
    
    func dropBall(at position: CGPoint) {
        let ballRadius: CGFloat = 10
        
        let randomBallIndex = Int(arc4random_uniform(5)) + 1
        let ballImageName = "user-ball-\(randomBallIndex)"
        
        let ballBackground = SKSpriteNode(imageNamed: ballImageName)
        ballBackground.size = CGSize(width: ballRadius * 2, height: ballRadius * 2)
        ballBackground.position = position
        
        let ball = SKSpriteNode(imageNamed: ballImageName)
        ball.size = CGSize(width: ballRadius * 2, height: ballRadius * 2)
        ball.position = position
        
        let ballNode = SKNode()
        ballNode.addChild(ball)
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
        ball.physicsBody?.restitution = 0.6
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = slotCategory
        
        addChild(ballNode)
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
        
        var totalPrice: Double {
            listOfUsers.reduce(0) { $0 + $1.totalPrice }
        }
        
        if let ballNode = ballNode, let slotNodeName = slotNodeName {
            if ballNode.userData == nil {
                ballNode.userData = NSMutableDictionary()
            }
            
            if ballNode.userData?["alertShown"] as? Bool == true {
                return
            }
            
            ballNode.userData?["alertShown"] = true
            
            
            withAnimation {
                self.selectedUserName = slotNodeName
                self.totalPrice = totalPrice
                self.showWinderAlert = true
            }
        }
    }
}
