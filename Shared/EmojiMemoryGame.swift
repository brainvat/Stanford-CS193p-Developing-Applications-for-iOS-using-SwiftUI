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
    
    @Published private var model: MemoryGame<String>
    @Published private var _score: Int = 0
    
    var theme: String
    
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
                      emojis: ["🛩", "🚗", "⛵️", "🚝", "🛻", "🚠", "🦼", "🛵", "🚛", "🚓", "🛳"]),
        "animals":
            cardTheme(label: "Animals", icon: "pawprint.circle", pairs: 6, color: Color.purple, // ios 15+
                      emojis: ["🐶", "🐨", "🦇", "🦉", "🐒", "🦅", "🐙", "🐢", "🦁", "🐌", "🐲"]),
        "food":
            cardTheme(label: "Food", icon: "leaf.circle", pairs: 3, color: Color.yellow, // ios 15+
                      emojis: ["🥥", "🍕", "🍟", "🧇", "🥖", "🍔", "🥑", "🥞", "🥮", "🍣", "☕️"]),
        "sports":
            cardTheme(label: "Sports", icon: "bicycle.circle", pairs: 7, color: Color.pink,
                      emojis: ["⚽️", "🏀", "🏈", "⚾️", "🎱", "🏑", "🥅", "🏓", "🛼", "🏹", "⛳️"]),
        "gadgets":
            cardTheme(label: "Gadgets", icon: "power.circle", pairs: 4, color: Color(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)), // ios 15+
                      emojis: ["⌚️", "💻", "☎️", "⌛️", "💾", "⚖️", "🌡", "📺", "🎥", "🕹", "📱"])
    ]
    
    init() {
        theme = EmojiMemoryGame.randomTheme
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    static func createMemoryGame(with theme: String = "", revealFirstCard: Bool = false) -> MemoryGame<String> {
        // make force unwrapping safe first
        let newTheme = EmojiMemoryGame.themes.contains(theme) ? theme : randomTheme
        let numberOfSets = min(cardThemes[newTheme]!.pairs, cardThemes[newTheme]!.emojis.count) // clamp on count
        let color = cardThemes[newTheme]!.color
        let emojis = cardThemes[newTheme]!.emojis.shuffled()
        return MemoryGame<String>(flipOne: revealFirstCard, numberOfSetsOfCards: numberOfSets, cardColor: color) { pairIndex in
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
    
    var name: String {
        EmojiMemoryGame.cardThemes[theme]!.label
    }
    
    var icon: String {
        EmojiMemoryGame.cardThemes[theme]!.icon
    }
    
    var score: Int {
        get {
            _score
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
        _score = model.score
    }
    
    func reset() {
        theme = EmojiMemoryGame.randomTheme
        model = EmojiMemoryGame.createMemoryGame(with: theme)
//        model = EmojiMemoryGame.createMemoryGame(revealFirstCard: true) // buggy
    }
}
