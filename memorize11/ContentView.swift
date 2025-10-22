//
//  ContentView.swift
//  memorize11
//
//  Created by 1 on 2025/10/20.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var viewModel:EmojiMemoryGame = EmojiMemoryGame()
    @State var  cardCount:Int = 1
    var body: some View {
        ScrollView{
            VStack{
                cards
                Spacer()
                cardCountAdjuster
            }
            .padding()
        }
     
    }
    var cardCountAdjuster:some View{
        HStack{
            cardRemover
            Spacer()
            Button("shuffle"){
                viewModel.shuffle()
            }
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    var cards:some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id:\.self){ index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
       
        .foregroundColor(.orange)
    }
    var cardRemover:some View{
        Button(action: {
            if(cardCount - 1 == 0){
                cardCount = viewModel.cards.count
            }else{
                cardCount -= 1
            }
        }, label:{
            Image(systemName: "folder.badge.minus.fill")
        })
    }
    
    var cardAdder:some View{
        Button(action:{
            if(cardCount  == viewModel.cards.count){
                cardCount = 1
            }else{
                cardCount += 1
            }
        },label: {
            Image(systemName:"plus.rectangle.fill.on.folder.fill")
        })
    }
}
struct CardView:View {
    var card:MemoryGame<String>.Card
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    var body: some View {
        ZStack{
            var base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)//用来适配卡片大小
                    .aspectRatio(1, contentMode: .fit)
            }.opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0:1)
        }
    }
}
#Preview {
    ContentView(viewModel: EmojiMemoryGame())
}
