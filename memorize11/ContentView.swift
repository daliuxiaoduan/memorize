//
//  ContentView.swift
//  memorize11
//
//  Created by 1 on 2025/10/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
           CardView(isFaceUp: false)
            CardView()
            CardView()
            CardView()
        }
        .padding()
        .foregroundColor(.orange)
        .font(.largeTitle)
    }
}
struct CardView:View {
   @State var isFaceUp:Bool = true
    var body: some View {
        ZStack{
            var base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp{
                base
                    .foregroundColor(.white)
                base
                    .strokeBorder(lineWidth: 2)
                Text("😂")
            }else{
                base
            }
        }.onTapGesture  {
            isFaceUp.toggle()
        }
    }
}
#Preview {
    ContentView()
}
