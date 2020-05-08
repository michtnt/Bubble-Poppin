//
//  HighScore.swift
//  BubblePoppin
//
//  Created by Michelle Tanoto on 3/5/20.
//  Copyright © 2020 Michelle Tanoto. All rights reserved.
//

import UIKit

class HighScore: NSObject {
    
    // HighScore attribute
    var name = String()
    var highScore = Int()
    
    // constructor 
    func HighScore(name: String, highScore: Int){
        self.name = name
        self.highScore = highScore
    }

}

