//
//  ContentView.swift
//  memorize11
//
//  Created by 1 on 2025/10/20.
//

import SwiftUI

struct ContentView: View {
    let emojis:[String] = ["❤️","😂","🤡","😈","😸","🙈","💀"]
    @State var  cardCount:Int = 4
    var body: some View {
        VStack{
            cards
            Spacer()
            cardCountAdjuster
        }
        .padding()
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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount,id:\.self){ index in
                CardView(content: emojis[index],isFaceUp: true)
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
        },label: {
            Image(systemName:"plus.rectangle.fill.on.folder.fill")
        })
    }
}
struct CardView:View {
    let content:String
    @State var isFaceUp:Bool = true
    var body: some View {
        ZStack{
            var base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0:1)
        }.onTapGesture  {
            isFaceUp.toggle()
        }
    }
}
#Preview {
    ContentView()
}
