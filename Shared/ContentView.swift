    //
    //  ContentView.swift
    //  Shared
    //
    //  Created by Allen Hammock on 8/5/21.
    //

    import SwiftUI

    struct ContentView: View {
        @ObservedObject var game: EmojiMemoryGame
        
        @State var cardCount = 8
        
        var body: some View {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                        ForEach(game.cards) { card in
                            CardView(card)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    game.choose(card)
                                }
                        }
                    }
                    .padding(.horizontal)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
        }
        
        init(_ game: EmojiMemoryGame) {
            self.game = game
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
        var card: MemoryGame<String>.Card
        
        var body: some View {
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 20.0)
                
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: 3)
                    Text(card.content)
                        .font(.system(size: 50))
                        .foregroundColor(.black)
                        .padding()
                } else if card.isMatched {
                    shape.opacity(0.0)
                } else {
                    shape.fill()
                }
                
            }
            .multilineTextAlignment(.center)

        }
        
        init(_ card: MemoryGame<String>.Card) {
            self.card = card
        }
    }



    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            let game = EmojiMemoryGame()
            Group {
                ContentView(game)
                    .preferredColorScheme(.light)
                    .previewDisplayName("Light Mode")
                ContentView(game)
                    .preferredColorScheme(.dark)
                    .previewDisplayName("Dark Mode")
            }
        }
    }
