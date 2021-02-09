//
//  CardView.swift
//  Concentration Game
//
//  Created by Aiana Miachina on 08.02.2021.
//

import SwiftUI

struct CardView: View {
    var card: Card
    let emoji: String
    
    var clickAction:() -> Void
    
    func cardColor() -> Color {
        if card.isMatched {
            return Color.red
        }
        return card.isFaceUp ? .clear : .blue
    }
    
    var body: some View {
        Button(action: clickAction, label: {
            Text(card.isFaceUp || card.isMatched ? emoji : " ")
                .font(card.isMatched ? .largeTitle : .title)
                .animation(card.isMatched ? .spring() : .none)

        })
        .frame(minWidth: 50, maxWidth: .infinity, minHeight: 50, maxHeight: .infinity, alignment: .center)
        .background(cardColor())
        .animation(.none)
        .opacity(card.isMatched ? 0 : 1)
        .animation(Animation.easeInOut(duration: 1.0).delay(0.5))
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(identifier: 1), emoji: ":-)", clickAction: {})
    }
}
