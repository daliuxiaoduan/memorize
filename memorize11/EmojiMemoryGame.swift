//
//  EmojiMemoryGame.swift
//  memorize11
//
//  Created by 1 on 2025/10/21.
//
//这里是ViewMode
import SwiftUI
import Combine
class EmojiMemoryGame: ObservableObject {
   private static let emojis:[String] =  ["❤️","😂","🤡","😈","😸","🙈","💀"]
    private static func createMemoryGame()->MemoryGame<String>{
        return MemoryGame<String>(numberOfPairOfCards: 13){index in
            if emojis.indices.contains(index){
                return emojis[index]
            }else{
                return "⁉️"
            }
        }
    }
    @Published  private var model = EmojiMemoryGame.createMemoryGame()
    var cards:Array<MemoryGame<String>.Card>{
        return model.cards
    }
    // MARK : - intents
    func shuffle(){
        model.shuffle()
    }
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
}
