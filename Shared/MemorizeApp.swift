//
//  MemorizeApp.swift
//  Shared
//
//  Created by Allen Hammock on 8/5/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(game)
        }
    }
}
