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
    private var indexOfFaceUpCard: Int?
    var name: String
    var icon: String
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { card.id == $0.id }),
           !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfFaceUpCard = nil
            } else {
                for index in 0..<cards.count { // cards.indices
                    cards[index].isFaceUp = false
                }
                indexOfFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(name: String = "", icon: String = "", flipOne: Bool = false, numberOfSetsOfCards: Int, cardColor: Color = Color.blue, createCardContent: (Int) -> CardContent) {
        self.name = name
        self.icon = icon
        if flipOne { indexOfFaceUpCard = Int.random(in: 0..<numberOfSetsOfCards) }
        for setIndex in 0..<numberOfSetsOfCards {
            let content = createCardContent(setIndex)
            let faceUp = (setIndex == indexOfFaceUpCard) && flipOne
            cards.append(Card(content, color: cardColor, id: setIndex * 2, isFaceUp: false))
            cards.append(Card(content, color: cardColor, id: setIndex * 2 + 1, isFaceUp: faceUp))
        }
        cards.shuffle() // ensures Task 13 requirement met
    }

    struct Card: Identifiable {
        var isFaceUp: Bool
        var isMatched: Bool = false
        var content: CardContent
        var color: Color
        var id: Int
        
        init(_ content: CardContent, color: Color, id: Int, isFaceUp: Bool = false) {
            self.isFaceUp = isFaceUp
            self.content = content
            self.color = color
            self.id = id
        }
    }
}
