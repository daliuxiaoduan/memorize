//
//  memorizeGame.swift
//  memorize11
//
//  Created by 1 on 2025/10/21.
//
//这里是mode
import Foundation
struct MemoryGame<CardContent>{
   private(set) var cards:Array<Card>
    init(numberOfPairOfCards: Int, cardContentFactory:(Int) -> CardContent ) {
        cards = []
      
        for pairIndex in 0..<max(2,numberOfPairOfCards){
            let content:CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    func choose(_ card:Card){
        
    }
    mutating func shuffle(){
        cards.shuffle()
    }
    struct Card{
        var isMatched = false
        var isFaceUp = true
        let content:CardContent
       
    }
}
