//
//  HighScoreView.swift
//  BubblePoppin
//
//  Created by Michelle Tanoto on 3/5/20.
//  Copyright © 2020 Michelle Tanoto. All rights reserved.
//

import UIKit

class HighScoresView: UIViewController {
    
    // passed variable
    var highScoresArray = Array<HighScore>();
    var playerName = "";
    
    // attribute related to the page
     @IBOutlet weak var home: UIButton!
    
    // coordinates to display result
    var nameXCoord = 120.5
    var scoreXCoord = 285.5
    var yCoord = 123.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // display highest scores limited to 10 only
        if highScoresArray.count <= 10 {
            for index in 0..<highScoresArray.count {
                // the user name
                let nameLabel = UILabel(frame: CGRect(x: 0, y:0, width: 200, height: 50))
                nameLabel.center = CGPoint(x: nameXCoord, y: yCoord)
                nameLabel.text = highScoresArray[index].name
                nameLabel.textAlignment = NSTextAlignment.center
                self.view.addSubview(nameLabel)
                
                // the user score
                let scorelabel = UILabel(frame: CGRect(x:0, y:0, width: 200, height: 50))
                scorelabel.center = CGPoint(x: scoreXCoord, y: yCoord)
                scorelabel.text = String(highScoresArray[index].highScore)
                scorelabel.textAlignment = NSTextAlignment.center
                self.view.addSubview(scorelabel)
                
                yCoord += 30
            }
        } else {
                for index in 0..<10 {
                    
                     // the user name
                     let nameLabel = UILabel(frame: CGRect(x: 0, y:0, width: 200, height: 50))
                     nameLabel.center = CGPoint(x: nameXCoord, y: yCoord)
                     nameLabel.text = highScoresArray[index].name
                     nameLabel.textAlignment = NSTextAlignment.center
                     self.view.addSubview(nameLabel)
                     
                     // the user score
                     let scorelabel = UILabel(frame: CGRect(x:0, y:0, width: 200, height: 50))
                     scorelabel.center = CGPoint(x: scoreXCoord, y: yCoord)
                     scorelabel.text = String(highScoresArray[index].highScore)
                     scorelabel.textAlignment = NSTextAlignment.center
                     self.view.addSubview(scorelabel)
                     
                     yCoord += 30
                  }
            }
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let highScores = highScoresArray
        
        // go to homeView with the selectedName
        if segue.identifier == "homeSegue" {
            if let target = segue.destination as? HomeView {
                target.selectedName = playerName
                target.highScoresArray = highScores
            }
        }
    }
    
}
