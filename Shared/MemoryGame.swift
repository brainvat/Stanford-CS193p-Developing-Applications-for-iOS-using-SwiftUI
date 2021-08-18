//
//  MemoryGame.swift
//  Memorize
//
//  Created by Allen Hammock on 8/15/21.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: [Card] // Array<Card>
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { card.id == $0.id }) {
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
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        
        init(_ content: CardContent, id: Int) {
            self.content = content
            self.id = id
        }
    }
}
