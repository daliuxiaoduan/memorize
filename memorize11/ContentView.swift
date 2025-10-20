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
    }
}
struct CardView:View {
    var isFaceUp:Bool = true
    var body: some View {
        ZStack{
            if isFaceUp{
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2)
                Text("😂")
            }else{
                RoundedRectangle(cornerRadius: 12)
            }
        }.font(.largeTitle)
    }
}
#Preview {
    ContentView()
}
