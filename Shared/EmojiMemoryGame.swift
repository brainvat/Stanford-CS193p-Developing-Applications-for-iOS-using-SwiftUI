//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Allen Hammock on 8/15/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let maxSets = 4
    private static var _theme = 0
    
    static let themes = [["faces", "Faces", "eye.circle"],
                         ["people", "People", "person.circle"],
                         ["flags", "Flags", "flag.circle"],
                         ["autos", "Autos", "car.circle"]]
    static let cards = [
        "faces" : ["😁", "🥸", "😖", "🤬", "🤯", "😍", "😷", "🥶", "😶‍🌫️", "😬", "🤢"],
        "people" : ["👮🏿‍♀️", "👩🏻‍🎓", "👨🏾‍🚀", "🙋🏽‍♀️", "👰🏼‍♀️", "👩🏻‍🚒", "👨🏿‍🔬", "👨🏻‍🌾", "🧑🏽‍🎤", "🤵🏻", "🤦🏽‍♀️"],
        "flags" : ["🇺🇸", "🇮🇸", "🇬🇧", "🇦🇫", "🇧🇷", "🇬🇾", "🇯🇵", "🇭🇳", "🇸🇪", "🇻🇳", "🇦🇺"],
        "autos" : ["🛩", "🚗", "⛵️", "🚝", "🛻", "🚠", "🦼", "🛵", "🚛", "🚓", "🛳"]
    ]
    
    static func createMemoryGame(matchedSets: Int = 8) -> MemoryGame<String> {
        return MemoryGame<String>(numberOfSetsOfCards: matchedSets.clamped(to: 1...maxSets)) { pairIndex in
            cards[faceSetKey]?[pairIndex] ?? "💣"
        }
    }
    
    static var theme: Int {
        get {
            _theme
        }
        
        set(newTheme) {
            _theme = newTheme.clamped(to: 0...(faceSets.count-1))
        }
    }
    
    static var faceSetKey: String {
        get {
            faceSets[theme.clamped(to: 0...(faceSets.count-1))]
        }
    }
    
    static var faceSets: [String] {
        get {
            EmojiMemoryGame.themes.map { $0[0] }
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()

    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func reset(_ theme: Int = 0) {
        EmojiMemoryGame.theme = theme
        model = EmojiMemoryGame.createMemoryGame()
    }
}

// https://stackoverflow.com/questions/36110620/standard-way-to-clamp-a-number-between-two-values-in-swift
extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
