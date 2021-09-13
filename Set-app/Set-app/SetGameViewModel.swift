//
//  SetGameViewModel.swift
//  Set-app
//
//  Created by Allen Hammock on 9/12/21.
//

import SwiftUI


enum CountFeature: Int, CaseIterable {
    case one = 1, two, three
}

enum ShapeFeature: CaseIterable {
    case diamond, squiggle, oval
}

enum ShadingFeature: CaseIterable {
    case solid, striped, open
}

enum ColorFeature: CaseIterable {
    case red, green, purple
}

class SetGameViewModel: ObservableObject {
    @Published private var gameModel: SetGameModel
    
    init() {
        gameModel = SetGameModel()
    }
}
