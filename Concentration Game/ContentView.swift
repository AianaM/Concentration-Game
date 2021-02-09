//
//  ContentView.swift
//  Concentration Game
//
//  Created by Aiana Miachina on 08.02.2021.
//

import SwiftUI

struct ContentView: View {
    @State var game = Concentration(numberOfCards: 4)
    @State var click = 0
        
    func getOpenedCards() -> Int {
        game.cards.filter{$0.isFaceUp}.count
    }
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(minimum: 50, maximum: 100), spacing: 10), count: 3);

    var body: some View {
        VStack {
            Text("Theme \(game.emoji_theme)")
                .font(.largeTitle)
            Text("Cards count \(game.cards.count)")
                .font(.caption2)
            Spacer()
            Text("Score: \(game.score)")
                .font(.headline)
            LazyVGrid(columns: columns, alignment: .center, spacing: 10 , content: {
                ForEach(game.cards.indices, id: \.self) { index in
                    let card = game.cards[index]
                    CardView(card: game.cards[index], emoji: game.getEmoji(index: card.identifier), clickAction: {
                        game.choceCard(index: index)
                        click+=1
                    })
                    .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                }
            })
            Text("Clicks \(click)").padding()
                .font(.caption2)
            Spacer()
            Button("New Game", action: {
                let numberOfCards = Int.random(in: 3...6)
                game = Concentration(numberOfCards: numberOfCards)
                click = 0
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
