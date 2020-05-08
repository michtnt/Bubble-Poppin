//
//  HomeView.swift
//  BubblePoppin
//
//  Created by Michelle Tanoto on 3/5/20.
//  Copyright © 2020 Michelle Tanoto. All rights reserved.
//

import UIKit

class HomeView: UIViewController {
    
    // variable declaration to connect to storyboard
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var allowPlay: UIButton!

    // variable declaration to trigger an action
     @IBAction func playButton(sender: Any) {
          performSegue(withIdentifier: "setupSegue", sender: nil)
      }
     @IBAction func highScoreButton(sender: Any) {
         performSegue(withIdentifier: "highscoreSegue", sender: nil)
      }
     @IBAction func textValidator(_ sender: Any) {
           if nameField.text == "" {
               allowPlay.isEnabled = false
           } else if nameField.text != "" {
               allowPlay.isEnabled = true
           }
       }
    
    // variable to store all the highest scores for display later
    var highScoresArray = Array<HighScore>()
    
    // passed variable
    var selectedName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(selectedName != ""){nameField.text = selectedName}
        // allowPlay.isEnabled = false;
        if (highScoresArray.isEmpty == true) {
            let firstScore = HighScore()
            firstScore.name = "Michelle"
            firstScore.highScore = 1
            highScoresArray.append(firstScore)
        }
    }

    // when segue is triggered (button press, etc.) this method will be triggered
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // variable to pass to next screen
        let name = nameField.text;
        let highscores = highScoresArray;
        
        // go to SetupView to proceed to play game
        if segue.identifier == "setupSegue" {
            if let target = segue.destination as? SetupView {
                target.selectedName = name!;
                target.highScoresArray = highscores;
            }
        }
        // go to HighScoresView to see all highscores
        if segue.identifier == "highscoreSegue" {
            if let target = segue.destination as? HighScoresView {
                target.highScoresArray = highscores;
                target.playerName = name!
            }
        }
    }
}

