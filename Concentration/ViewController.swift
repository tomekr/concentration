//
//  ViewController.swift
//  Concentration
//
//  Created by Rabczak, Tomek on 5/16/18.
//  Copyright © 2018 Rabczak, Tomek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // If you make a var lazy, it doesn't initialize until someone tries to use it.
    // The downside is that you can't use didSet. Also no one can use game until
    // cardButtons is initialized
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    // This is an example of a Computed Property
    var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count+1) / 2
        }
    }
    
    private var emojiThemes = [
        ["🎃", "👻", "🤡", "👅", "🐃", "🍱", "🍩", "🎬", "🚌"],
        ["🏌🏻", "🏇", "🥈", "🚴🏽‍♀️", "⛹🏾‍♀️", "🤽🏻‍♀️", "🏄🏼‍♀️", "🏋️‍♀️", "🤼‍♂️"],
        ["🎹", "🥁", "🎼", "🎧", "🎷", "🎬", "🎤", "🎸", "🎻"]
    ]
    private lazy var randomIndex = Int(arc4random_uniform(UInt32(emojiThemes.count)))
    private lazy var emojiChoices = emojiThemes[randomIndex]
    
    // same as Dictionary<Int,String>()
    var emoji = [Int:String]()
    
    // Instance variable (i.e. property). All instance variables
    // need to be initialized.
    private(set) var flipCount = 0 {
        // Property observer that will execute anytime the variable changes
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    // Outlets are almost always private since they're internal details about our UI.
    // No reason to make this public
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        startNewGame()
    }
    
    func startNewGame() {
        let randomIndex = Int(arc4random_uniform(UInt32(emojiThemes.count)))
        emojiChoices = emojiThemes[randomIndex]
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
    }
    
    func addNewTheme(with emojiSet: [String]) {
        emojiThemes.append(emojiSet)
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }

    
    func emoji(for card: Card) -> String {
        // you can simulate and && with a comma in Swift
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        // The below one-liner is exactly the same as:
        // if emoji[card.identifier] != nil {
        //     return emoji[card.identifier]!
        // } else {
        //     return "?"
        // }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

