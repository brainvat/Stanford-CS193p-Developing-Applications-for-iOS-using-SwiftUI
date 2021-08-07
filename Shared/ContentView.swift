//
//  ContentView.swift
//  Shared
//
//  Created by Allen Hammock on 8/5/21.
//

import SwiftUI

struct ContentView: View {
    var faces = ["🛩", "🚗", "⛵️", "🚝", "🛻", "🚠", "🦼", "🛵", "🚛", "🚓", "🛳"]
    @State var faceCount = 5
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .padding()
            ScrollView {
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                    ForEach(faces[0..<faceCount], id: \.self) { card in
                        CardView(content: card)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .padding(.horizontal)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
//            HStack {
//                removeButton
//                Spacer()
//                Text ("Reveal")
//                Spacer()
//                addButton
//
//            }.font(.title).padding(.horizontal)
        }
    }
    
    var removeButton: some View {
        Button {
            faceCount = max(1, faceCount - 1)
        } label: {
            Image(systemName: "minus.square")
        }
    }
    
    var addButton: some View {
        Button {
            faceCount = min(faces.count - 1, faceCount + 1)
        } label: {
            Image(systemName: "plus.square")
        }
    }
}
struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .padding()
            } else {
                shape.fill()
            }
            
        }
        .multilineTextAlignment(.center)
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.light)
                .previewDisplayName("Light Mode")
            ContentView()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
        }
    }
}
