//
//  MemorizeApp.swift
//  Shared
//
//  Created by Allen Hammock on 8/5/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game)
        }
    }
}
