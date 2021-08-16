//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Allen Hammock on 8/15/21.
//

import SwiftUI

class EmojiMemoryGame {
    private var model: MemoryGame = createCardSet()
    private static let maxSets = 20
    static let cards = [
        "faces" : ["😁", "🥸", "😖", "🤬", "🤯", "😍", "😷", "🥶", "😶‍🌫️", "😬", "🤢"],
        "people" : ["👮🏿‍♀️", "👩🏻‍🎓", "👨🏾‍🚀", "🙋🏽‍♀️", "👰🏼‍♀️", "👩🏻‍🚒", "👨🏿‍🔬", "👨🏻‍🌾", "🧑🏽‍🎤", "🤵🏻", "🤦🏽‍♀️"],
        "flags" : ["🇺🇸", "🇮🇸", "🇬🇧", "🇦🇫", "🇧🇷", "🇬🇾", "🇯🇵", "🇭🇳", "🇸🇪", "🇻🇳", "🇦🇺"],
        "autos" : ["🛩", "🚗", "⛵️", "🚝", "🛻", "🚠", "🦼", "🛵", "🚛", "🚓", "🛳"]
    ]
    
    static func createCardSet(cardSet setIndex: Int = 0, matchedSets: Int = 4) -> MemoryGame<String> {
        let faceSets = Array(EmojiMemoryGame.cards.keys)
        let faceSetIndex = faceSets[setIndex.clamped(to: 0...(faceSets.count-1))]
        return MemoryGame(numberOfSetsOfCards: matchedSets.clamped(to: 1...maxSets)) { setIndex in
            cards[faceSetIndex]?[0] ?? "💣"
        }
    }
}

// https://stackoverflow.com/questions/36110620/standard-way-to-clamp-a-number-between-two-values-in-swift
extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
