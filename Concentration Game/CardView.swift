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
        
    var body: some View {
        Button(action: clickAction, label: {
            Text(card.isFaceUp || card.isMatched ? emoji : " ")
                .frame(minWidth: 50, maxWidth: .infinity, minHeight: 50, maxHeight: .infinity, alignment: .center)
        })
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(identifier: 1), emoji: ":-)", clickAction: {})
    }
}
