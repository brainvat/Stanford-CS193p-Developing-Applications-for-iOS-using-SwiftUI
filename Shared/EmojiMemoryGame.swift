//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Allen Hammock on 8/15/21.
//

import SwiftUI

struct cardTheme {
    var label: String
    var icon: String
    var pairs: Int
    var color: Color
    var emojis: [String]
}

class EmojiMemoryGame: ObservableObject {
    private static let maxSets = 6
        
    static let cardThemes = [
        "faces":
            cardTheme(label: "Faces", icon: "eye.circle", pairs: 15, color: Color.red, // too many pairs
                      emojis: ["😁", "🥸", "😖", "🤬", "🤯", "😍", "😷", "🥶", "😶‍🌫️", "😬", "🤢"]),
        "people":
            cardTheme(label: "People", icon: "person.circle", pairs: 4, color: Color.blue,
                      emojis: ["👮🏿‍♀️", "👩🏻‍🎓", "👨🏾‍🚀", "🙋🏽‍♀️", "👰🏼‍♀️", "👩🏻‍🚒", "👨🏿‍🔬", "👨🏻‍🌾", "🧑🏽‍🎤", "🤵🏻", "🤦🏽‍♀️"]),
        "flags":
            cardTheme(label: "Flags", icon: "flag.circle", pairs: 2, color: Color.green,
                      emojis: ["🇺🇸", "🇮🇸", "🇬🇧", "🇦🇫", "🇧🇷", "🇬🇾", "🇯🇵", "🇭🇳", "🇸🇪", "🇻🇳", "🇦🇺"]),
        "autos":
            cardTheme(label: "Autos", icon: "car.circle", pairs: 7, color: Color.orange,
                      emojis: ["🛩", "🚗", "⛵️", "🚝", "🛻", "🚠", "🦼", "🛵", "🚛", "🚓", "🛳"])
    ]
    
    static func createMemoryGame(with theme: String = "") -> MemoryGame<String> {
        // make force unwrapping safe first
        let newTheme = EmojiMemoryGame.themes.contains(theme) ? theme : randomTheme
        let numberOfSets = max(cardThemes[newTheme]!.pairs, cardThemes[newTheme]!.emojis.count) // clamp on count
        let color = cardThemes[newTheme]!.color
        let emojis = cardThemes[newTheme]!.emojis.shuffled()
        return MemoryGame<String>(numberOfSetsOfCards: numberOfSets, cardColor: color) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    static var themes: [String] {
        get {
            EmojiMemoryGame.cardThemes.keys.map { $0 }
        }
    }
    
    static var randomTheme: String {
        get {
            themes.shuffled()[0]
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
    
    func reset() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
