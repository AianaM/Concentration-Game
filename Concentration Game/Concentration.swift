//
//  Concentration.swift
//  Concentration Game
//
//  Created by Aiana Miachina on 08.02.2021.
//

import Foundation

class Concentration {
    var cards:[Card] = []
    
    var score = 0
    var flippedCards:Set<Int> = []
    
    var emoji = [
        "Animals": ["🐮", "🐔", "🐰", "🐶", "🐱", "🐭", "🐯", "🦊", "🐨", "🐼", "🐽"],
        "Food": ["🍎", "🍔", "🌭", "🍤", "🥨", "🥐", "🥗", "🍭", "🍿", "🍕"],
        "Sport": ["⚽️", "🏀", "🎱", "🏓", "🥊", "⛸", "🛹", "🏆", "🏉", "🥎"],
        "Plants": ["🍀", "💐", "🌸", "🌼", "🌹", "🌿", "🌻", "🍄", "🌴", "🌷"],
        "Games": ["🎯", "🎳", "🎮", "🎰", "🎲", "🧸", "♠️", "🧩", "♟", "🀄"],
        "Office": ["📎", "🖋", "📚", "📋", "📈", "📥", "🗂", "🗓", "📌", "✂️"]
    ]
    
    var emoji_theme: String
    
    var emojiCards = [Int: String]()
    
    var choicenCard:Int?
    
    init(numberOfCards: Int) {
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
    
    func choceCard(index: Int) -> Void {
        guard !cards[index].isFaceUp else {
            return
        }
        
        cards[index].isFaceUp = true

        if (choicenCard == nil) {
            choicenCard = index
            
            // close all cards
            cards.enumerated().forEach { (cardIndex, card) in
                if cardIndex != index {
                    cards[cardIndex].isFaceUp = false
                }
            }
        }else{
            if cards[choicenCard!].identifier == cards[index].identifier {
                cards[choicenCard!].isMatched = true
                cards[index].isMatched = true
                score += 2
            }else{
                if flippedCards.contains(cards[choicenCard!].identifier){
                    score -= 1
                    print(flippedCards)
                    print("1")
                }
                if flippedCards.contains(cards[index].identifier) {
                    score -= 1
                    print(flippedCards)
                    print("2")
                }
                flippedCards.insert(cards[choicenCard!].identifier)
                flippedCards.insert(cards[index].identifier)
            }
            choicenCard = nil
        }
    }
}
