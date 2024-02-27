//
//  GameViewController.swift
//  sidescrollerNotes
//
//  Created by ANDREW KAISER on 2/22/24.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    // CONNECTING
    var play: GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        // forces the game to be in landscape mode
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
                    UIDevice.current.setValue(value, forKey: "orientation")
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                play = scene as! GameScene
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscapeRight
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func jumpAction(_ sender: Any) {
        play.jump()
    }
    @IBAction func switchDirectionsAction(_ sender: Any) {
        play.switchDirect()
    }
    
}
