//
//  GameViewController.swift
//  Road Racer
//
//  Created by Jaspreet on 2020-06-19.
//  Copyright © 2020 Jaspreet. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AudioToolbox
import AVFoundation

class GameViewController: UIViewController {
var carDrivingPlayer: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
       // backgroundmusic()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameMenuScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
  
    
}
