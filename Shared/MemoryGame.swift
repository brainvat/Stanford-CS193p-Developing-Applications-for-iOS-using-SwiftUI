//
//  MemoryGame.swift
//  Memorize
//
//  Created by Allen Hammock on 8/15/21.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: [Card] // Array<Card>
    private let matchesPerSet = 2
    
    func choose(_ card: Card) {
        
    }
    
    init(numberOfSetsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for setIndex in 0..<numberOfSetsOfCards {
            let content = createCardContent(setIndex)
            for _ in 0..<matchesPerSet {
                cards.append(Card(content))
            }
        }
    }
    
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        
        init(_ content: CardContent) {
            self.content = content
        }
    }
}
