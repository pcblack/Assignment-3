//
//  GameMenuScene.swift
//  Road Racer
//
//  Created by Jaspreet on 2020-06-19.
//  Copyright © 2020 Jaspreet. All rights reserved.
//

import UIKit
import SpriteKit
import AudioToolbox
import AVFoundation


class GameMenuScene: SKScene {
    var carDrivingPlayer: AVAudioPlayer?
    var startGame = SKLabelNode()
    var bestScore = SKLabelNode()
    var gameScore = SKLabelNode()
    var audioNode = SKSpriteNode()
    var soundcheck = true
    let gameSettings = Settings.sharedInstance
    
    override func didMove(to view: SKView) {
        if(soundcheck){
        backgroundmusic()
        }
        else{
           print(soundcheck)
        }
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        startGame = self.childNode(withName: "startGame") as! SKLabelNode
        bestScore = self.childNode(withName: "bestScore") as! SKLabelNode
        gameScore = self.childNode(withName: "gameScore") as! SKLabelNode

        
        gameSettings.highScore = UserDefaults().integer(forKey: "GameHighScore")
        
        bestScore.text = "Best Score: \(gameSettings.highScore)"
        gameScore.text = "Game Score: \(gameSettings.gameScore)"
        
        
        audioNode = self.childNode(withName: "audioNode") as! SKSpriteNode
//        audioNode = SKSpriteNode(imageNamed: "audio")
        gameSettings.audioSetting = true


    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let touchLocation = touch.location(in: self)
            if atPoint(touchLocation).name == "startGame" {
                stopSound()
                soundcheck=false
                let menuScene = SKScene(fileNamed: "GameScene")!
                menuScene.scaleMode = .aspectFill
                view?.presentScene(menuScene, transition: SKTransition.crossFade(withDuration: 1.9))
                    
                    
                   // (withDuration: TimeInterval(1.5)))
            }
            
            if atPoint(touchLocation).name == "audioNode" {
                if gameSettings.audioSetting == true {
                    audioNode.texture = SKTexture(imageNamed: "noAudio")
                    stopSound()
                    gameSettings.audioSetting = false
                }else {
                    audioNode.texture = SKTexture(imageNamed: "audio")
                    backgroundmusic()
                    gameSettings.audioSetting = true
                }
            }
        }
    }
    func backgroundmusic() {
             guard let url = Bundle.main.url(forResource: "background", withExtension: "mp3") else { return }
             do {
                 try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                 try AVAudioSession.sharedInstance().setActive(true)
                 
                 /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                 carDrivingPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                 
                 /* iOS 10 and earlier require the following line:
                  player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
                 
                 guard let player = carDrivingPlayer else { return }
                 
                 player.play()
                 player.numberOfLoops = -1

             } catch let error {
                 print(error.localizedDescription)
             }
         }
    
    func stopSound() {
        carDrivingPlayer?.stop()
        carDrivingPlayer = nil
    }
}

