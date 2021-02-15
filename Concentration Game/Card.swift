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

struct FlippedCard {
    let index: Int
    let identifier: Int
    let dt = Date.init()
}

struct ExtraScore {
    let startDt = Date.init()
    var flipsLog = [FlippedCard]()
    var count: (flips: Int, founds: Int) = (0, 0)
    var speed: (flips: TimeInterval, founds: TimeInterval) = (0, 0)
    
    var foundTime: TimeInterval = 0
    
    var extraPoints = 0
    
    mutating func flip(cardIndex: Int, cardIdentifier: Int) {
        flipsLog.append(FlippedCard(index: cardIndex, identifier: cardIdentifier))
        count.flips = flipsLog.count
        speed.flips = Date().timeIntervalSince(startDt) / Double.init(count.flips)
        
        if let logs = count.flips > 2 ? flipsLog.prefix(count.flips - 2) : nil, count.flips % 2 == 0{
            let lastPick = flipsLog[count.flips - 2]
            if lastPick.identifier == cardIdentifier {

                let flippedThisCard = logs.filter {$0.identifier == cardIdentifier}
                
                if flippedThisCard.count > 0 {
                    count.founds += 1
                    foundTime += Date().timeIntervalSince(lastPick.dt)
                    speed.founds = foundTime / Double.init(count.founds) * Double.init(flippedThisCard.count)
                    
                    if speed.founds < 2 { extraPoints += 1 }
                }
            }
            
        }
    }
    
    mutating func stat() -> [(Int, (flips: Int, intervalsSum: TimeInterval, foundInterval: TimeInterval?))] {
        var flipsStat = [Int: (flips: Int, intervalsSum: TimeInterval, foundInterval: TimeInterval?)]()
        
        for (i, flip) in flipsLog.enumerated() {
            if i > 0, i % 2 != 0 {
                let lastFlip = flipsLog[i - 1]
                let interval = flip.dt.timeIntervalSince(lastFlip.dt)

                if lastFlip.identifier != flip.identifier {
                    var flips = flipsStat[flip.identifier]?.flips ?? 0
                    var intervalSum = flipsStat[flip.identifier]?.intervalsSum ?? 0
                                        
                    flipsStat[flip.identifier] = (flips + 1, intervalSum + interval, nil)
                    
                    flips = flipsStat[lastFlip.identifier]?.flips ?? 0
                    intervalSum = flipsStat[lastFlip.identifier]?.intervalsSum ?? 0

                    flipsStat[lastFlip.identifier] = (flips + 1, intervalSum + interval, nil)
                } else {
                    flipsStat[lastFlip.identifier] = (flipsStat[lastFlip.identifier]?.flips ?? 0, flipsStat[lastFlip.identifier]?.intervalsSum ?? interval, interval)
                }
            }
        }
        let sortedFlipsStat = flipsStat.sorted {
            let (_, (flips2, intervalsSum2, foundInterval2)) = $0
            let (_, (flips1, intervalsSum1, foundInterval1)) = $1
            
            if flips1 == flips2 {
                return intervalsSum1 > intervalsSum2
            } else if intervalsSum1 == intervalsSum2, foundInterval1 != nil,  foundInterval2 != nil {
                return foundInterval1! > foundInterval2!
            }
            return flips1 > flips2
        }
        return sortedFlipsStat
    }
}
