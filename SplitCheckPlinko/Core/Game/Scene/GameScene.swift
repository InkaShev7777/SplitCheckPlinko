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
        backgroundColor = .white
        
        // Set up physics
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        self.physicsWorld.contactDelegate = self
        
        // Add an upside-down pyramid of pegs
        let numRows = 7
        let pegSpacing: CGFloat = 62
        
//        for row in 0..<numRows {
//            let numPegs = (row + 2) + 1
//            for col in 0..<numPegs {
//                let xOffset = frame.midX - CGFloat(numPegs - 1) * pegSpacing / 2
//                let peg = SKShapeNode(circleOfRadius: 10)
//                peg.fillColor = .blue
//                peg.position = CGPoint(
//                    x: xOffset + CGFloat(col) * pegSpacing,
//                    y: frame.height - CGFloat(row + 1) * pegSpacing * 1.5
//                )
//                peg.physicsBody = SKPhysicsBody(circleOfRadius: 10)
//                peg.physicsBody?.isDynamic = false
//                addChild(peg)
//            }
//        }
        for row in 2..<numRows {
            var numPegs =  row + 1
            
            for col in 0..<numPegs {
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
        
        // Add slots at the bottom
        let screenWidth = frame.width
        let tileHeight: CGFloat = 20
        let tileWidth = screenWidth / CGFloat(listOfUsers.count)
        let tileYPosition: CGFloat = 50
        
        for (index, user) in listOfUsers.enumerated() {
            // Create the slot (tile)
            let slot = SKShapeNode(rectOf: CGSize(width: tileWidth, height: tileHeight))
            slot.fillColor = .green
            slot.position = CGPoint(
                x: tileWidth / 2 + CGFloat(index) * tileWidth,
                y: tileYPosition
            )
            slot.name = user.userName // Assign user name as the node name
            slot.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: tileWidth, height: tileHeight))
            slot.physicsBody?.isDynamic = false
            slot.physicsBody?.categoryBitMask = slotCategory
            slot.physicsBody?.contactTestBitMask = ballCategory
            addChild(slot)
            
            // Create the label for the user's name
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
        
        // Restrict ball dropping to the top 20% of the screen
        if location.y > frame.height * 0.8 {
            dropBall(at: CGPoint(x: location.x, y: frame.height - 50))
        }
    }
    
    // Handle collisions between the ball and the slots
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA.node
        let bodyB = contact.bodyB.node
        
        // Determine which node is the ball and which is the slot
        let ballNode = (bodyA?.name == nil ? bodyA : bodyB)
        let slotNodeName = bodyA?.name ?? bodyB?.name

        // Ensure this is a valid contact and prevent duplicate alerts
        if let ballNode = ballNode, let slotNodeName = slotNodeName {
            // Check if the ball has already triggered an alert
            if ballNode.userData == nil {
                ballNode.userData = NSMutableDictionary()
            }
            
            if ballNode.userData?["alertShown"] as? Bool == true {
                // Alert already shown for this ball
                return
            }
            
            // Mark that the alert has been shown for this ball
            ballNode.userData?["alertShown"] = true
            
            // Show the alert
            showAlert(for: slotNodeName, ballNode: ballNode)
        }
    }
    // Show an alert with the user's name and remove the ball after pressing "OK"
    func showAlert(for userName: String, ballNode: SKNode) {
        DispatchQueue.main.async {
            guard let view = self.view else { return }

            let alert = UIAlertController(
                title: "User Slot Hit",
                message: "The ball hit \(userName)'s slot!",
                preferredStyle: .alert
            )

            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                ballNode.removeFromParent()
            }
            alert.addAction(okAction)
            
            if let viewController = view.window?.rootViewController {
                viewController.present(alert, animated: true)
            }
        }
    }
}




//class GameScene: SKScene {
//    var listOfUsers: [User]
//    
//    init(size: CGSize, listOfUsers: [User]) {
//        self.listOfUsers = listOfUsers
//        super.init(size: size)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func didMove(to view: SKView) {
//        backgroundColor = .white
//        
//        // Scene physics boundary
//        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
//        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
//        
//        // Add an upside-down pyramid of pegs
//        let numRows = 7 // Total rows for the pyramid
//        let pegSpacing: CGFloat = 60 // Distance between pegs
//        
//        for row in 0..<numRows {
//            let numPegs = row + 1 // Increasing number of pegs per row
//            for col in 0..<numPegs {
//                let xOffset = frame.midX - CGFloat(numPegs - 1) * pegSpacing / 2
//                let peg = SKShapeNode(circleOfRadius: 10)
//                peg.fillColor = .blue
//                peg.position = CGPoint(
//                    x: xOffset + CGFloat(col) * pegSpacing,
//                    y: frame.height - CGFloat(row + 1) * pegSpacing * 1.5
//                )
//                peg.physicsBody = SKPhysicsBody(circleOfRadius: 10)
//                peg.physicsBody?.isDynamic = false
//                addChild(peg)
//            }
//        }
//        
//        // Add slots at the bottom
//        let screenWidth = frame.width
//        let tileHeight: CGFloat = 20
//        let tileWidth = screenWidth / CGFloat(listOfUsers.count) // Dynamically calculate tile width
//        let tileYPosition: CGFloat = 50 // Y position for all tiles
//        
//        for (index, user) in listOfUsers.enumerated() {
//            // Create the slot (tile)
//            let slot = SKShapeNode(rectOf: CGSize(width: tileWidth, height: tileHeight))
//            slot.fillColor = .green
//            slot.position = CGPoint(
//                x: tileWidth / 2 + CGFloat(index) * tileWidth, // Center each tile within its allocated space
//                y: tileYPosition
//            )
//            slot.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: tileWidth, height: tileHeight))
//            slot.physicsBody?.isDynamic = false
//            addChild(slot)
//            
//            // Create the label for the user's name
//            let userLabel = SKLabelNode(text: user.userName)
//            userLabel.fontColor = .black
//            userLabel.fontSize = 12
//            userLabel.verticalAlignmentMode = .center // Align text vertically
//            userLabel.position = CGPoint(
//                x: slot.position.x,
//                y: slot.position.y + tileHeight // Adjust position above the tile
//            )
//            addChild(userLabel)
//        }
//    }
//    
//    func dropBall(at position: CGPoint) {
//        let ball = SKShapeNode(circleOfRadius: 15)
//        ball.fillColor = .red
//        ball.position = position
//        ball.physicsBody = SKPhysicsBody(circleOfRadius: 15)
//        ball.physicsBody?.restitution = 0.6
//        ball.physicsBody?.isDynamic = true
//        addChild(ball)
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        let location = touch.location(in: self)
//        
//        // Restrict ball dropping to the top 20% of the screen
//        if location.y > frame.height * 0.8 {
//            dropBall(at: CGPoint(x: location.x, y: frame.height - 50)) // Drop ball near the top
//        }
//    }
//}
