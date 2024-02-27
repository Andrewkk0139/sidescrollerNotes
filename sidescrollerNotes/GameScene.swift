//
//  GameScene.swift
//  sidescrollerNotes
//
//  Created by ANDREW KAISER on 2/22/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    var ball: SKSpriteNode!
    var wall2: SKSpriteNode!
    var ballDx = 500
    var isGrounded = false
    // creates a camera object
    let cam = SKCameraNode()
    var score = 0
    
    // didMove func is bascially viewDidLoad
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        // anything we add to the screen is a childNode
        // creates a refrene to ball
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        wall2 = self.childNode(withName: "wall2") as! SKSpriteNode
        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text = "Score: \(score)"
        // sets the given camera equal to our camera
        self.camera = cam
    }
    override func update(_ currentTime: TimeInterval) {
        print("This is ball Dx velocity: \(ball.physicsBody!.velocity.dx)")
        cam.position.x = ball.position.x
        // offset Y so the camera isn't always centering the ball. IDK WHY IT'S + 150
        cam.position.y = ball.position.y + 150
        scoreLabel.position.x = cam.position.x + 500
        scoreLabel.position.y = cam.position.y + 250
        if ball.position.y < -480 {
            respawn()
        }
        if ball.physicsBody!.velocity.dx < 100 && ball.physicsBody!.velocity.dx > -100 {
            respawn()
            ball.physicsBody?.velocity.dx = CGFloat(ballDx)
        }

    }
    
    func respawn(){
        ball.position.x = -414
        ball.position.y = 208
    }
    
    func jump(){
        if isGrounded {
            ball.physicsBody?.velocity.dy = 750
            isGrounded = false
        }
    }
    func switchDirect(){
        switch ballDx {
        case 500:
            ballDx = -500
            ball.physicsBody?.velocity.dx = CGFloat(ballDx)
        case -500:
            ballDx = 500
            ball.physicsBody?.velocity.dx = CGFloat(ballDx)
        default:
            print("if this prints, we're done for")
        }
    }
    
//    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
//        print("checkin")
//        guard let key = presses.first?.key else { return }
//        print(key.keyCode)
//        switch key.keyCode {
//        case .keypad0:
//            print("huh")
//        default:
//            super.pressesBegan(presses, with: event)
//        }
//
//    }
    // when a contact happens this func happenes
    func didBegin(_ contact: SKPhysicsContact) {
        print("hit")
        // checks if only the player and coin collided
        if (contact.bodyA.node?.name == "ball" && contact.bodyB.node?.name == "coin") || (contact.bodyA.node?.name == "coin" && contact.bodyB.node?.name == "ball") {
            score+=1
            scoreLabel.text = "Score: \(score)"
            if contact.bodyA.node?.name == "coin"{
                // removeFromParents deletes the objects
                contact.bodyA.node?.removeFromParent()
                // makes the ball not bounce off the coin
                ball.physicsBody?.velocity.dx = CGFloat(ballDx)
            } else {
                contact.bodyB.node?.removeFromParent()
                ball.physicsBody?.velocity.dx = CGFloat(ballDx)
            }
        }
        //
        if ((contact.bodyA.node?.name == "ball" && contact.bodyB.node?.name == "ground") || (contact.bodyA.node?.name == "ground" && contact.bodyB.node?.name == "ball")) || (contact.bodyA.node?.name == "ball" && contact.bodyB.node?.name == "jumpingBlock") || (contact.bodyA.node?.name == "jumpingBlock" && contact.bodyB.node?.name == "ball") {
            isGrounded = true
            if(contact.bodyA.node?.name == "ball" && contact.bodyB.node?.name == "ground") || (contact.bodyA.node?.name == "ground" && contact.bodyB.node?.name == "ball"){
                ball.physicsBody!.velocity.dx = CGFloat(ballDx)
            }
        }
        if (contact.bodyA.node?.name == "ball" && contact.bodyB.node?.name == "coin2") || (contact.bodyA.node?.name == "coin2" && contact.bodyB.node?.name == "ball") {
            score+=1
            scoreLabel.text = "Score: \(score)"
            wall2.removeFromParent()
            if contact.bodyA.node?.name == "coin2"{
                // removeFromParents deletes the objects
                contact.bodyA.node?.removeFromParent()
                // makes the ball not bounce off the coin
                ball.physicsBody?.velocity.dx = CGFloat(ballDx)
            } else {
                contact.bodyB.node?.removeFromParent()
                ball.physicsBody?.velocity.dx = CGFloat(ballDx)
            }
        }
    }
    

}
