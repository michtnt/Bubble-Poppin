//
//  GameView.swift
//  BubblePoppin
//
//  Created by Michelle Tanoto on 3/5/20.
//  Copyright © 2020 Michelle Tanoto. All rights reserved.
//

import UIKit

class GameView: UIViewController {
    
    // passed attribute
     var selectedBubbles = Int()
     var selectedName = ""
     var selectedDuration = Int()
     var highScoresArray = Array<HighScore>()
    
    // bubble color; NOTE: SUBJECT TO CHANGE
    @IBOutlet weak var black: Bubble!
    @IBOutlet weak var blue: Bubble!
    @IBOutlet weak var green: Bubble!
    @IBOutlet weak var pink: Bubble!
    @IBOutlet weak var red: Bubble!
    
    // game related attributes
    @IBOutlet weak var gameTime: UILabel!
    @IBOutlet weak var scoreCount: UILabel!
    @IBOutlet weak var highScore: UILabel!
    
    // segue to redirect player to homeSegue and highscoreSegue when player finish playing
    @IBOutlet weak var segue: UIButton!
    @IBOutlet weak var otherSegue: UIButton!

    // player game area (not include the header part [time, score, and highscore]
    @IBOutlet weak var safeArea: UIView!
    
    // game related attributes
    var bubbleCount = 0 // total bubbles
    var currentBubble = Bubble() // to check whether user tap on the same bubble respectively
    var previousBubble = Bubble() // to check whether user tap on the same bubble respectively
    var highestScore = 0 // current highest score
    var bubblePoints = Array<Bubble>() // array to store bubble points
    var score = Int() // player's score
    var probability = Int() // bubble probability
    var colourCounter = Int() // color determinant based on probability
    var timer = Timer() // initialise timer
    
    // when bubbles are pressed it is added to the player's score and update the score display
    @IBAction func pressingBubble(_ sender: Bubble) {
        var points = Int()
        if (sender == previousBubble) {
            // if curent bubble is the same with previous bubble x1.5 more
            points = Int(Double(sender.points) * 1.5)
        } else {
            points = sender.points
        }
        score += points
        scoreCount.text = String(score)
        
        sender.removeFromSuperview()
        bubbleCount -= 1
        previousBubble = sender
        
        if (score > highestScore) {
            highScore.text = String(score)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup
        bubbleCount = 0
        
        // set up points for the bubbles
        red.points = 1 // 40% probability
        pink.points = 2 // 30% probability
        green.points = 5 // 15% probability
        blue.points = 8 // 10% probability
        black.points = 10 // 5% probability
        
        // push all the bubbles points data to an array
        self.bubblePoints = [red, pink, green, blue, black]
        
        // set up a timer for gameplay
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(run), userInfo: nil, repeats: true)
        
        // set the displayed highscore field from iterating through highScoresArray
        // and get the highest score
        highestScore = getHighestScore(array: highScoresArray)
        highScore.text = String(highestScore)
        
        // set the player's score as 0 and timer based on player's
        // selected duration initially
        score = 0
        gameTime.text = String(selectedDuration)
        
        // clear the bubbles in the screen
        clearScreen()
        // only allow player to go to highscoreSegue or homeSegue when the game finishes
        segue.isEnabled = false
        otherSegue.isEnabled = false
    }
    
     
    // when timer runs this function needs to be called
    @objc func run() {
        // when the timer hits 0
        if (selectedDuration == 0) {
            timer.invalidate()
            var isOldPlayer = false // if the player is previously on the highscore array
            var higherScore = false // player is on highscore array previously and have higher score now
            
            (isOldPlayer, higherScore) = checkOldPlayer(array: highScoresArray, isOldPlayer: isOldPlayer, higherScore: higherScore )
       
            // if it's new player
            if (higherScore == true || isOldPlayer == false){
                let newPlayer = HighScore()
                newPlayer.name = selectedName
                newPlayer.highScore = score
                let newIndex = allocateArray(array: highScoresArray)
                highScoresArray.insert(newPlayer, at: newIndex)
            }
            
            // show the modal box for player to navigate to homeSegue or highscoreSegue
            showModalBox();
            
        // when timer still goes on
        } else {
            clearScreen()
            selectedDuration -= 1
            // update the displayed game time
            gameTime.text = String(selectedDuration)
            
            // bubbles probability to show up
            probability = Int(arc4random()) % self.selectedBubbles + 1
            var count = 0
            while (probability > count) {
                count += 1
                colourCounter = Int(arc4random())%100 + 1
                let gameBubbles = addBubbles()
                if (gameBubbles != nil) {
                    self.safeArea.addSubview(gameBubbles!)
                }
            }
        }
    }
  
    
    // supporting game functions
    
      func addBubbles() -> Bubble? {
          currentBubble = colourProbability(bubble: currentBubble)
          let bubble = currentBubble
          bubble.addTarget(self, action: #selector(pressingBubble(_:)), for: UIControl.Event.touchUpInside)
          let xx: Int = (Int(40 + arc4random_uniform(UInt32(self.safeArea.frame.size.width - 80))))
          let yy: Int = (Int(40 + arc4random_uniform(UInt32(self.safeArea.frame.size.height - 80))))
          let c = CGPoint(x: xx, y: yy)
          bubble.center = c
          for others in safeArea.subviews {
              if (bubble.frame.intersects(others.frame)) {
                  return nil
              }
          }
          return bubble
      }
    
    
    func colourProbability(bubble: Bubble) -> Bubble {
        switch colourCounter {
        case 0...40:
            return bubblePoints[0] // 40% red
        case 41...70:
            return bubblePoints[1] // 30% pink
        case 71...85:
            return bubblePoints[2] // 15% green
        case 86...95:
            return bubblePoints[3] // 10% blue
        default:
            return bubblePoints[4] // 5% red
        }
    }
    
    func showModalBox(){
         let alert = UIAlertController(title: "Game Over", message: "Good job! Your score was \(score)", preferredStyle: .alert)
        
         // segue direction for player to navigate
         alert.addAction(UIAlertAction(title:"High Scores", style: .default, handler: {
             action in
             self.performSegue(withIdentifier: "highScoreSegue", sender: self)
         }))
         alert.addAction(UIAlertAction(title:"Home", style: .cancel,handler:{
             action in
             self.performSegue(withIdentifier: "homeSegue", sender: self)
         }))
         self.present(alert, animated: true)
    }
    
    func clearScreen() {
         for bubble in bubblePoints {
             bubble.removeFromSuperview()
         }
     }
    
     func getHighestScore(array: Array<HighScore>) -> Int {
         var highestScore = 0
        // if there's only one highscore in array automatically that's the highest
         if (array.count == 1) {
             highestScore = array[0].highScore
         }
        // if no then iterate through all and keep comparing until reach the highest score
         else if (array.count >= 2) {
             for i in (0..<array.count) {
                 if (array[i].highScore > highestScore) {
                     highestScore = array[i].highScore
                 }
             }
         }
         return highestScore
     }
    
    
     func findDataIndex(player: String, array: Array<HighScore>) -> Int {
         var playerIndex = Int()
         for index in 0..<array.count {
             if (array[index].name == selectedName) {
                 playerIndex = index
             }
         }
         return playerIndex
     }
    
        
    func allocateArray(array: Array<HighScore>) -> Int {
        for i in 0..<array.count{
            if(score >= array[i].highScore){
                return i
            }
        }
        return array.count
    }
    
    func checkOldPlayer(array: Array <HighScore>, isOldPlayer: Bool, higherScore: Bool) -> (Bool, Bool){
        var isOldPlayer = isOldPlayer;
        var higherScore = higherScore;
        
        for data in array {
           // if this player's name is found in the highScoresArray and this player's score
           // is higher than her previous score, replace it.
           if (selectedName.lowercased() == data.name.lowercased() && score >= data.highScore) {
               let oldData = findDataIndex(player: selectedName, array: array)
               // remove the old data
               highScoresArray.remove(at: oldData)
               isOldPlayer = true
               higherScore = true
           } else if (selectedName.lowercased() == data.name.lowercased() && score < data.highScore) {
               isOldPlayer = true
               higherScore = false
           }
        }
        return (isOldPlayer, higherScore)
    }
    
    // go to other screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let highscores = highScoresArray
        if (segue.identifier == "homeSegue") {
            if let target = segue.destination as? HomeView {
                target.highScoresArray = highscores
            }
        }
        if (segue.identifier == "highscoreSegue") {
            if let target = segue.destination as? HighScoresView {
                target.highScoresArray = highscores
            }
        }
    }

}




