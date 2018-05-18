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
    
    var indexOfOneAndOnlyFaceCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        // Actually set will default to newValue so you don't actually have to
        // have that in the method signature
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        // This is where the meat of our game logic lives
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceCard = index
            }
            
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
