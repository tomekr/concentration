//
//  Concentration.swift
//  Concentration
//
//  Created by Rabczak, Tomek on 5/16/18.
//  Copyright © 2018 Rabczak, Tomek. All rights reserved.
//

import Foundation

struct Concentration
{
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceCard: Int? {
        get {
            // oneAndOnly is an extension we defined at the bottom of this file
            return  cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        // Actually set will default to newValue so you don't actually have to
        // have that in the method signature
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
        // This is where the meat of our game logic lives
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
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
        assert(numberOfPairsOfCards > 0, "init(\(numberOfPairsOfCards)): you must have at least 1 pair of cards")
        // Countable Range is a Sequence so we can for loop over it
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            // Remember Card is a struct so it'll get copied (even when append is used)
            cards += [card, card]
        }
        
        // TODO: HOMEWORK: Shuffle the cards
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
