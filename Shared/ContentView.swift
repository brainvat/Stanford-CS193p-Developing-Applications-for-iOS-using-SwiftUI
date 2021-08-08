//
//  ContentView.swift
//  Shared
//
//  Created by Allen Hammock on 8/5/21.
//

import SwiftUI

struct ContentView: View {
    var cards = [
        "faces" : ["😁", "🥸", "😖", "🤬", "🤯", "😍", "😷", "🥶", "😶‍🌫️", "😬", "🤢"],
        "people" : ["👮🏿‍♀️", "👩🏻‍🎓", "👨🏾‍🚀", "🙋🏽‍♀️", "👰🏼‍♀️", "👩🏻‍🚒", "👨🏿‍🔬", "👨🏻‍🌾", "🧑🏽‍🎤", "🤵🏻", "🤦🏽‍♀️"],
        "flags" : ["🇺🇸", "🇮🇸", "🇬🇧", "🇦🇫", "🇧🇷", "🇬🇾", "🇯🇵", "🇭🇳", "🇸🇪", "🇻🇳", "🇦🇺"],
        "autos" : ["🛩", "🚗", "⛵️", "🚝", "🛻", "🚠", "🦼", "🛵", "🚛", "🚓", "🛳"]
    ]
    
    @State var cardCount = 8
    @State var theme = "autos"
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .padding()
            ScrollView {
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                    let cardFaces = (cards[theme] ?? [""]).shuffled()
                    ForEach(cardFaces[0..<cardCount], id: \.self) { card in
                        CardView(content: card)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .padding(.horizontal)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
            HStack {
                Spacer()
                ThemeButton(icon: "car.circle", label: "Autos") {
                    theme = "autos"
                    cardCount = Int.random(in: 8...cards[theme]!.count)
                }
                Spacer()
                ThemeButton(icon: "flag.circle", label: "Flags") {
                    theme = "flags"
                    cardCount = Int.random(in: 8...cards[theme]!.count)
                }
                Spacer()
                ThemeButton(icon: "person.circle", label: "People") {
                    theme = "people"
                    cardCount = Int.random(in: 8...cards[theme]!.count)
                }
                Spacer()
                ThemeButton(icon: "eye.circle", label: "Faces") {
                    theme = "faces"
                    cardCount = Int.random(in: 8...cards[theme]!.count)
                }
                Spacer()
            }.padding([.horizontal, .bottom])
        }
    }
}

struct ThemeButton: View {
    var icon: String
    var label: String
    var action: () -> ()
        
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Image(systemName: icon)
                    .font(.largeTitle)
                    .frame(height: 50)
                Text(label)
                    .font(.caption)
            }
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
                    .font(.system(size: 50))
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
