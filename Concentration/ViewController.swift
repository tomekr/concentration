//
//  ViewController.swift
//  Concentration
//
//  Created by Rabczak, Tomek on 5/16/18.
//  Copyright © 2018 Rabczak, Tomek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Instance variable (i.e. property). All instance variables
    // need to be initialized.
    var flipCount = 0 {
        // Property observer that will execute anytime the variable changes
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    var emojiChoices = ["🎃", "👻", "🤡", "👅"]
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        // use let instead of var because this is a constant
        let cardNumber = cardButtons.index(of: sender)!
        print("cardNumber = \(cardNumber)")
        flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        print("DEBUG: flipCard(withEmoji: \(emoji))")
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}

