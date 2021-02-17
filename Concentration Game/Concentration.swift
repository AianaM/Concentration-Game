//
//  Concentration.swift
//  Concentration Game
//
//  Created by Aiana Miachina on 08.02.2021.
//

import Foundation

class Concentration {
    private (set) var cards:[Card] = []
    
    private (set) var emoji = [
        "Animals": ["🐮", "🐔", "🐰", "🐶", "🐱", "🐭", "🐯", "🦊", "🐨", "🐼", "🐽"],
        "Food": ["🍎", "🍔", "🌭", "🍤", "🥨", "🥐", "🥗", "🍭", "🍿", "🍕"],
        "Sport": ["⚽️", "🏀", "🎱", "🏓", "🥊", "⛸", "🛹", "🏆", "🏉", "🥎"],
        "Plants": ["🍀", "💐", "🌸", "🌼", "🌹", "🌿", "🌻", "🍄", "🌴", "🌷"],
        "Games": ["🎯", "🎳", "🎮", "🎰", "🎲", "🧸", "♠️", "🧩", "♟", "🀄"],
        "Office": ["📎", "🖋", "📚", "📋", "📈", "📥", "🗂", "🗓", "📌", "✂️"]
    ]
    
    let emoji_theme: String
    private (set) var emojiCards = [Int: String]()
    
    private (set) var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            let faceUpCards = cards.indices.filter({cards[$0].isFaceUp})
            if faceUpCards.count == 1 {
                return faceUpCards.first
            }
            return nil
        }
        
        set {
            cards = cards.enumerated().map { (index, card) -> Card in
                var card = card
                card.isFaceUp = index == newValue || index == indexOfTheOneAndOnlyFaceUpCard
                return card
            }
        }
    }
    private var flippedCard: Set<Int> = []
    
    private (set) var score = 0
    
    private (set) var scoreExtra = ExtraScore()
        
    init() {
        let numberOfCards = Int.random(in: 6...8)
        for _ in 1...numberOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
        emoji_theme = emoji.randomElement()!.key
    }
    
    func getEmoji(index: Int) -> String {
        if !emojiCards.keys.contains(index), emoji.keys.contains(emoji_theme), !emoji[emoji_theme]!.isEmpty {
            let emojiIndex = Int.random(in: 0..<emoji[emoji_theme]!.count)
            emojiCards[index] = emoji[emoji_theme]!.remove(at: emojiIndex)
        }
        return emojiCards[index] ?? "?"
    }
    
    func flipCard(index: Int) -> Void {
        if indexOfTheOneAndOnlyFaceUpCard != nil {
            if cards[index].identifier == cards[indexOfTheOneAndOnlyFaceUpCard!].identifier {
                cards[indexOfTheOneAndOnlyFaceUpCard!].isMatched = true
                cards[index].isMatched = true
                score += 2
            }else{
                score -= flippedCard.contains(cards[index].identifier) ? 1 : 0
                score -= flippedCard.contains(cards[indexOfTheOneAndOnlyFaceUpCard!].identifier) ? 1 : 0
                flippedCard.insert(cards[index].identifier)
                flippedCard.insert(cards[indexOfTheOneAndOnlyFaceUpCard!].identifier)
            }
        }
        indexOfTheOneAndOnlyFaceUpCard = index
        scoreExtra.flip(cardIndex: index, cardIdentifier: cards[index].identifier)
    }
}
