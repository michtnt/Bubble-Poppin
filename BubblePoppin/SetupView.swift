//
//  SetupView.swift
//  BubblePoppin
//
//  Created by Michelle Tanoto on 3/5/20.
//  Copyright © 2020 Michelle Tanoto. All rights reserved.
//

import UIKit

class SetupView: UIViewController {
    
    // passed variable declaration from HomeView
    var selectedName = "";
    var highScoresArray = Array<HighScore>();
    
    // variable declaration to connect to storyboard
     @IBOutlet weak var durationLabel: UILabel!
     @IBOutlet weak var bubbleLabel: UILabel!
     @IBOutlet weak var durationSlider: UISlider!
     @IBOutlet weak var bubbleSlider: UISlider!
    
    // variable declaration to trigger an action
    @IBAction func startButton(_ sender: Any) {
        performSegue(withIdentifier: "startSegue", sender: nil)
    }
    
    @IBAction func durationSliderChange(sender: UISlider) {
          let durationSliderValue = Int(sender.value)
          durationLabel.text = "\(durationSliderValue)"
      }
    
    @IBAction func bubbleSliderChange(sender: UISlider) {
          let bubbleSliderValue = Int(sender.value)
          bubbleLabel.text = "\(bubbleSliderValue)"
    }
    
    // default duration and bubbles value
    var defaultBubbles = 15
    var defaultDuration = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // when segue is triggered (button press, etc.) this method will be triggered
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // variable to pass to the next screen
        let gameDuration = Int(durationSlider.value)
        let gameBubbles = Int(bubbleSlider.value)
        
        // go to GameView to play the game
        if segue.identifier == "startSegue" {
            if let target = segue.destination as? GameView
            {
                target.selectedName = selectedName;
                target.highScoresArray = highScoresArray;
                target.selectedDuration = gameDuration;
                target.selectedBubbles = gameBubbles;
            }
        }
        if segue.identifier == "backSegue" {
              if let target = segue.destination as? HomeView
              {
                  target.selectedName = selectedName;
                  target.highScoresArray = highScoresArray;
              }
          }
        
    }
}


