//
//  Concentration.swift
//  Concentration
//
//  Created by Rabczak, Tomek on 5/16/18.
//  Copyright © 2018 Rabczak, Tomek. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    func chooseCard(at index: Int) {
        if cards[index].isFaceUp {
            cards[index].isFaceUp = false
        } else {
            cards[index].isFaceUp = true
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        // Countable Range is a Sequence so we can for loop over it
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            // Remember Card is a struct so it'll get copied (even when append is used)
            cards += [card, card]
        }
        
        // TODO: HOMEWORK: Shuffle the cards
    }
}
