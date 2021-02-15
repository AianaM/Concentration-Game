//
//  ContentView.swift
//  Concentration Game
//
//  Created by Aiana Miachina on 08.02.2021.
//

import SwiftUI

struct ContentView: View {
    @State var game = Concentration()
    @State var click = 0
    
    func theme_colors() -> (bgColor: Color, cardBgColor: Color, fontColor: Color) {
        switch game.emoji_theme {
        case "Animals":
            return (
                Color(UIColor(red: 0.95, green: 0.98, blue: 0.93, alpha: 1.00)),
                Color(red: 0.90, green: 0.22, blue: 0.27),
                Color(UIColor(red: 0.11, green: 0.21, blue: 0.34, alpha: 1.00))
            )
        case "Food":
            return (
                Color(UIColor(red: 0.95, green: 0.91, blue: 0.39, alpha: 1.00)),
                Color(UIColor(red: 0.02, green: 0.86, blue: 0.95, alpha: 1.00)),
                Color(UIColor(red: 0.95, green: 0.57, blue: 0.89, alpha: 1.00))
            )
        case "Sport":
            return (
                Color(UIColor(red: 0.01, green: 0.45, blue: 0.33, alpha: 1.00)),
                Color(UIColor(red: 0.05, green: 0.85, blue: 0.17, alpha: 1.00)),
                Color(UIColor(red: 0.95, green: 0.90, blue: 0.21, alpha: 1.00))
            )
        case "Plants":
            return (
                Color(UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)),
                Color(UIColor(red: 0.85, green: 0.35, blue: 0.17, alpha: 1.00)),
                Color(UIColor(red: 0.31, green: 0.55, blue: 0.07, alpha: 1.00))
            )
        case "Games":
            return (
                Color(red: 0.25, green: 0.92, blue: 0.83),
                Color(red: 1.00, green: 0.13, blue: 0.43),
                Color.white
            )
        case "Office":
            return (
                Color(UIColor(red: 0.87, green: 0.95, blue: 0.95, alpha: 1.00)),
                Color(UIColor(red: 0.47, green: 0.70, blue: 0.85, alpha: 1.00)),
                Color(UIColor(red: 0.45, green: 0.37, blue: 0.14, alpha: 1.00))
            )
        default:
            return (
                Color(red: 1.00, green: 0.92, blue: 0.98),
                Color(red: 0.56, green: 0.60, blue: 0.69), Color.white
            )
        }
    }
    
    func getOpenedCards() -> Int {
        game.cards.filter{$0.isFaceUp}.count
    }
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(minimum: 50, maximum: 100), spacing: 10), count: 4);
    
    var body: some View {
        VStack {
            Text("Theme \(game.emoji_theme)").font(.largeTitle).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding()
            HStack{
                Text("Cards: \(game.cards.count)")
                Text("Flips: \(game.scoreExtra.count.flips)")
                Text("Clicks \(click)")
            }
            HStack {
                Text(String(format: "Flips Speed: %.2f", game.scoreExtra.speed.flips))
                Text(String(format: "Founds Speed: %.2f", game.scoreExtra.speed.founds))
            }
            HStack {
                Text("Score: \(game.score)")
                Text("Extra: \(game.scoreExtra.extraPoints)")
                Text("Total: \(game.score + game.scoreExtra.extraPoints)")
            }.font(.headline)
            .padding(.vertical)
            if game.cards.filter({!$0.isMatched}).count == 0 {
                WinnerView(stat: game.scoreExtra.stat(), emoji: {identifier in game.getEmoji(index: identifier)})
            } else {
                LazyVGrid(columns: columns, alignment: .center, spacing: 10 , content: {
                    ForEach(game.cards.indices, id: \.self) { index in
                        let card = game.cards[index]
                        CardView(card: game.cards[index], emoji: game.getEmoji(index: card.identifier), clickAction: {
                            game.clickedCard(index: index)
                            click+=1
                        })
                        .font(game.cards[index].isMatched ? .largeTitle : .title)
                        .animation(.none)
                        .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .background(game.cards[index].isMatched ? .clear : theme_colors().cardBgColor)
                        .opacity(game.cards[index].isMatched ? 0 : 1)
                        .animation(Animation.easeInOut(duration: 1.0).delay(0.5))
                    }
                })
            }
            Spacer()
            Button(action: {
                game = Concentration()
                click = 0
            }, label: {
                Text("New Game").font(.title3).padding()
            })
            .background(theme_colors().fontColor)
            .foregroundColor(theme_colors().bgColor)
            .padding()
        }
        .background(theme_colors().bgColor)
        .foregroundColor(theme_colors().fontColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
