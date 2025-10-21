//
//  ContentView.swift
//  memorize11
//
//  Created by 1 on 2025/10/20.
//

import SwiftUI
struct MemoryCard: Identifiable {
    let id = UUID()
    let content: String
    var isMatched: Bool = false // 是否已匹配
}
struct ContentView: View {
    let emojis:[String] = ["❤️","😂","🤡","😈","😸","🙈","💀","😎","🤠","😱","💩"]
    @State private var curCards: [MemoryCard] = [] // 修改：存储卡片模型而非字符串
    @State private var cardCount: Int = 1
    @State private var matchCount:Int = 0
    // 新增：记录翻开的卡片（最多两张）
    @State private var flippedCards: [MemoryCard] = []
    // 新增：防止快速连续点击的锁
    @State private var isProcessing: Bool = false
    @State var totalCount:Int = 0
    private func updateCurEmojis() {
        let selectedEmojis = Array(emojis.prefix(cardCount))
        curCards = selectedEmojis.flatMap{emoji in
            [MemoryCard(content:emoji),MemoryCard(content: emoji)]
        }
        .shuffled()
        flippedCards.removeAll()
        totalCount = 0
        matchCount = 0
     }
    private func handleCardTap(_ card: MemoryCard) {
        // 过滤已匹配或正在处理的卡片
        guard !card.isMatched, !isProcessing, !flippedCards.contains(where: { $0.id == card.id }) else {
            return
        }
        totalCount+=1;
        flippedCards.append(card)
        
        if flippedCards.count == 2{
            isProcessing = true
           
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5,){
                
                let first = flippedCards[0]
                let second = flippedCards[1]
                if first.content == second.content {
                    matchCount += 1
                    curCards.indices.forEach{index in
                        if curCards[index].id == first.id || curCards[index].id == second.id{
                            curCards[index].isMatched = true
                        }
                    }
                }
                flippedCards.removeAll()
                isProcessing = false
            }
        }
    }
    var body: some View {
        VStack{
            cards
            Spacer()
            Text("胜利")
                .font(.largeTitle)
                .foregroundColor(.red)
                .opacity(matchCount == cardCount ? 1 : 0)
            Spacer()
            cardCountAdjuster
            Text(String(totalCount))
                .font(.largeTitle)
                .foregroundColor(.orange)
        }
        .padding()
        .onAppear(perform: updateCurEmojis)
    }
    var cardCountAdjuster:some View{
        HStack{
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    var cards:some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
            
            ForEach(curCards){ card in
                CardView(content: card.content, isFaceUp:flippedCards.contains(where:{
                    $0.id == card.id
                }) || card.isMatched, isMatched: card.isMatched)
                .onTapGesture {
                    handleCardTap(card)
                }
            }
            
        }
        .foregroundColor(.orange)
    }
    var cardRemover:some View{
        Button(action: {
            if(cardCount - 1 == 0){
                cardCount = emojis.count
            }else{
                cardCount -= 1
            }
            updateCurEmojis()
        }, label:{
            Image(systemName: "folder.badge.minus.fill")
        })
    }
 
    var cardAdder:some View{
        Button(action:{
            if(cardCount  == emojis.count){
                cardCount = 1
            }else{
                cardCount += 1
            }
            updateCurEmojis()
        },label: {
            Image(systemName:"plus.rectangle.fill.on.folder.fill")
        })
    }
}
struct CardView:View {
    let content:String
    let isFaceUp:Bool
    let isMatched:Bool
    var body: some View {
        ZStack{
            var base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0:1)
        }
    }
}
#Preview {
    ContentView()
}
