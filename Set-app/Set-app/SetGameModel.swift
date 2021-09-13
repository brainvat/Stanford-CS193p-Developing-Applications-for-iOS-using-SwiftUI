//
//  SetGameModel.swift
//  Set-app
//
//  Created by Allen Hammock on 9/12/21.
//
//  Rules for Set Game
//  https://en.wikipedia.org/wiki/Set_(card_game)

import Foundation

struct SetGameModel {
    private(set) var cards = Array<Card>()
    private var _score: Int
    
    init() {
        _score = 0
    }
    
    struct Card: Identifiable {
        let id: Int
    }
}

