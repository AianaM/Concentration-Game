//
//  Score.swift
//  Concentration Game
//
//  Created by Aiana Miachina on 09.02.2021.
//

import Foundation

struct PickedCard {
    let cardIndex: Int
    let timeInterval: TimeInterval
}

class Score {
    var pickedCards = [PickedCard]()
    var lastClickDt = Date.init()
    
    var score = 0
}
