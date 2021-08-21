//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Allen Hammock on 8/15/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let maxSets = 6
    private static var _theme = 0
    
    // TODO: this two-array system is ugly
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
        let numberOfSets = matchedSets >= 1 && matchedSets <= maxSets ? matchedSets : maxSets
        return MemoryGame<String>(numberOfSetsOfCards: numberOfSets) { pairIndex in
            cards[faceSetKey]?[pairIndex] ?? "💣"
        }
    }
    
    static var theme: Int {
        get {
            _theme
        }
        
        set(newTheme) {
            let themeIndex = newTheme >= 0 && newTheme < faceSets.count ? newTheme : faceSets.count-1
            _theme = themeIndex
        }
    }
    
    static var faceSetKey: String {
        get {
            let themeIndex = theme >= 0 && theme < faceSets.count ? theme : faceSets.count-1
            return faceSets[themeIndex]
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
