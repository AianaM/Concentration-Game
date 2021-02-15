//
//  Concentration.swift
//  Concentration Game
//
//  Created by Aiana Miachina on 08.02.2021.
//

import Foundation

class Concentration {
    var cards:[Card] = []
    
    var emoji = [
        "Animals": ["🐮", "🐔", "🐰", "🐶", "🐱", "🐭", "🐯", "🦊", "🐨", "🐼", "🐽"],
        "Food": ["🍎", "🍔", "🌭", "🍤", "🥨", "🥐", "🥗", "🍭", "🍿", "🍕"],
        "Sport": ["⚽️", "🏀", "🎱", "🏓", "🥊", "⛸", "🛹", "🏆", "🏉", "🥎"],
        "Plants": ["🍀", "💐", "🌸", "🌼", "🌹", "🌿", "🌻", "🍄", "🌴", "🌷"],
        "Games": ["🎯", "🎳", "🎮", "🎰", "🎲", "🧸", "♠️", "🧩", "♟", "🀄"],
        "Office": ["📎", "🖋", "📚", "📋", "📈", "📥", "🗂", "🗓", "📌", "✂️"]
    ]
    
    let emoji_theme: String
    var emojiCards = [Int: String]()
    
    var lastCardIndex: Int?
    var flippedCard: Set<Int> = []
    
    var score = 0
    
    var scoreExtra = ExtraScore()
        
    init() {
        let numberOfCards = Int.random(in: 6...8)
        for _ in 1...numberOfCards {
            let card = Card(identifier: Card.getIdentifier())
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
    
    func clickedCard(index: Int) -> Void {
        guard !cards[index].isFaceUp else {
            return
        }
        
        cards[index].isFaceUp = true
        scoreExtra.flip(cardIndex: index, cardIdentifier: cards[index].identifier)
        
        if lastCardIndex != nil {
            if cards[lastCardIndex!].identifier == cards[index].identifier {
                cards[lastCardIndex!].isMatched = true
                cards[index].isMatched = true
                score += 2
            }else{
                score -= flippedCard.contains(cards[index].identifier) ? 1 : 0
                score -= flippedCard.contains(cards[lastCardIndex!].identifier) ? 1 : 0
                
                flippedCard.insert(cards[index].identifier)
                flippedCard.insert(cards[lastCardIndex!].identifier)
            }
            self.lastCardIndex = nil
        }else{
            for cardIndex in cards.indices {
                cards[cardIndex].isFaceUp = cardIndex == index
            }
            self.lastCardIndex = index
        }
    }
}
