//
//  Card.swift
//  Concentration Game
//
//  Created by Aiana Miachina on 08.02.2021.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    let identifier: Int
    
    static var identifiries = 0
    static func getIdentifier() -> Int {
        identifiries += 1
        return identifiries
    }
}
