//
//  MemoryGame.swift
//  Memorize
//
//  Created by Allen Hammock on 8/15/21.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards = Array<Card>() // Array<Card>
    private(set) var name: String
    private(set) var icon: String

    private var indexOfFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    private var _score: Int
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { card.id == $0.id }),
           !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    _score += 2
                } else {
                    _score -= cards[chosenIndex].previouslySeen ? 1 : 0
                    _score -= cards[potentialMatchIndex].previouslySeen ? 1 : 0
                    cards[chosenIndex].previouslySeen = true
                    cards[potentialMatchIndex].previouslySeen = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfFaceUpCard = chosenIndex
            }
        }
    }
    
    init(name: String = "", icon: String = "", flipOne: Bool = false, numberOfSetsOfCards: Int, cardColor: Color = Color.blue, createCardContent: (Int) -> CardContent) {
        self.name = name
        self.icon = icon
        self._score = 0
        if flipOne { indexOfFaceUpCard = Int.random(in: 0..<numberOfSetsOfCards) }
        for setIndex in 0..<numberOfSetsOfCards {
            let content = createCardContent(setIndex)
            let faceUp = (setIndex == indexOfFaceUpCard) && flipOne
            cards.append(Card(content, color: cardColor, id: setIndex * 2, isFaceUp: false))
            cards.append(Card(content, color: cardColor, id: setIndex * 2 + 1, isFaceUp: faceUp))
        }
        cards.shuffle() // ensures Task 13 requirement met
    }

    var score: Int {
        _score
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool
        var isMatched = false
        var previouslySeen = false
        let content: CardContent
        let color: Color
        let id: Int
        
        init(_ content: CardContent, color: Color, id: Int, isFaceUp: Bool = false) {
            self.isFaceUp = isFaceUp
            self.content = content
            self.color = color
            self.id = id
        }
    }
}

extension Array {
    var oneAndOnly: Element?  {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
