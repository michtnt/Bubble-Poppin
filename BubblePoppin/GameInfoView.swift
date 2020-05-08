//
//  GameInfoView.swift
//  BubblePoppin
//
//  Created by Michelle Tanoto on 3/5/20.
//  Copyright © 2020 Michelle Tanoto. All rights reserved.
//

import UIKit

class GameInfoView: UIViewController {
    // screen related attribute
    @IBOutlet weak var ready: UILabel!
    @IBOutlet weak var hint: UILabel!

    // time count
    var time = 3
    
    // Timer
    var timer = Timer();
    
    // passed attribute
    var selectedName = "";
    var highScoresArray = Array<HighScore>();
    var selectedDuration = Int();
    var selectedBubbles = Int();
    
    override func viewDidLoad() {
           super.viewDidLoad()
           timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(set), userInfo: nil, repeats: true)
       }
    
    @objc func set(){
        time -= 1;
        ready.text = String(time);
        if(time == 1){
           hint.text = "You have \(selectedDuration) seconds! \n Goodluck \(selectedName)!"
        } else if(time == 0){
           // move to next controller
           performSegue(withIdentifier: "gameSegue", sender: nil)
           timer.invalidate()
       }
  }

     // when segue is triggered (button press, etc.) this method will be triggered
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             
          // go to SetupView to proceed to play game
          if segue.identifier == "gameSegue" {
              if let target = segue.destination as? GameView {
                 target.selectedName = selectedName;
                 target.highScoresArray = highScoresArray;
                 target.selectedDuration = selectedDuration;
                 target.selectedBubbles = selectedBubbles;
            }
          }
      }
}
