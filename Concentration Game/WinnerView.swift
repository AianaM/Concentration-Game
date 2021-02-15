//
//  WinnerView.swift
//  Concentration Game
//
//  Created by Aiana Miachina on 10.02.2021.
//

import SwiftUI

struct WinnerView: View {
    let stat: [(Int, (flips: Int, intervalsSum: TimeInterval, foundInterval: TimeInterval?))]
    
    let emoji: (_ identifier: Int) -> String
    
    var body: some View {
        List {
            Section(header: Text("Stats").frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            ) {
                HStack {
                    Text("Card").frame(width: 50, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("Flips ").frame(width: 50, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("Summary Time").frame(width: 120, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("Found Time").frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, idealHeight: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                ForEach(stat.indices, id: \.self) { index in
                    let (identifier, (flips, intervalsSum, foundInterval)) = stat[index]
                    HStack {
                        Text("\(emoji(identifier))").frame(width: 50, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Text("\(flips)").frame(width: 50, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Text("\(intervalsSum)").frame(width: 120, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Text("\(foundInterval ?? 0)").frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, idealHeight: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
            }
        }.foregroundColor(.gray)
    }
}

struct WinnerView_Previews: PreviewProvider {
    static let stat: [(Int, (flips: Int, intervalsSum: TimeInterval, foundInterval: TimeInterval?))] = []
    
    static var previews: some View {
        WinnerView(stat: stat, emoji: {_ in "??"})
    }
}
