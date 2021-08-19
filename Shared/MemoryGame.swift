//
//  MemoryGame.swift
//  Memorize
//
//  Created by Allen Hammock on 8/15/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card] // Array<Card>
    private var indexOfFaceUpCard: Int?
    
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
    
    init(numberOfSetsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for setIndex in 0..<numberOfSetsOfCards {
            let content = createCardContent(setIndex)
            cards.append(Card(content, id: setIndex * 2))
            cards.append(Card(content, id: setIndex * 2 + 1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        
        init(_ content: CardContent, id: Int) {
            self.content = content
            self.id = id
        }
    }
}
