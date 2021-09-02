    //
    //  EmojiMemoryGameView.swift
    //  Shared
    //
    //  Created by Allen Hammock on 8/5/21.
    //

    import SwiftUI

    struct EmojiMemoryGameView: View {
        @ObservedObject private var game: EmojiMemoryGame
        @GestureState private var isUpdating = false
        
        var body: some View {
            VStack {
                HStack {
                    Image(systemName: game.icon)
                    Text(game.name)
                }
                .foregroundColor(.primary)
                .font(.title)
                .padding()
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: GridDrawingConstants.gridItemSize))]) {
                        ForEach(game.cards) { card in
                            CardView(card)
                                .foregroundColor(card.color)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    game.choose(card)
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                HStack {
                    Button(action: { game.reset() }) {
                        HStack {
                            Image(systemName: "restart.circle")
                            Text("New Game")
                        }
                    }
                    Spacer()
                    Text("Score: \(game.score)")
                }
                .foregroundColor(.primary)
                .padding()
            }.statusBar(hidden: true)
        }
        
        init(_ game: EmojiMemoryGame) {
            self.game = game
        }
        
        private struct GridDrawingConstants {
            static let gridItemSize: CGFloat = 60
        }
    }

    struct CardView: View {
        private var card: EmojiMemoryGame.Card
        
        var body: some View {
            GeometryReader(content: { geometry in
                ZStack {
                    let shape = RoundedRectangle(cornerRadius: CardDrawingConstants.cornerRadius)
                    
                    if card.isFaceUp {
                        shape.fill().foregroundColor(.white)
                        shape.strokeBorder(lineWidth: CardDrawingConstants.lineWidth)
                        Text(card.content)
                            .font(font(in: geometry.size))
                            .foregroundColor(.black)
                            .padding()
                    } else if card.isMatched {
                        shape.opacity(0.0)
                    } else {
                        shape.fill()
                    }
                    
                }
                .multilineTextAlignment(.center)
            })
        }
        
        init(_ card: EmojiMemoryGame.Card) {
            self.card = card
        }
        
        private struct CardDrawingConstants {
            static let cornerRadius: CGFloat = 15
            static let lineWidth: CGFloat = 3
            static let fontScale: CGFloat = 0.5
        }
        
        private func font(in size: CGSize) -> Font {
            Font.system(size: CardDrawingConstants.fontScale * min(size.width, size.height))
        }
    }



    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            let game = EmojiMemoryGame()
            Group {
                EmojiMemoryGameView(game)
                    .preferredColorScheme(.light)
                    .previewDisplayName("Light Mode")
                EmojiMemoryGameView(game)
                    .preferredColorScheme(.dark)
                    .previewDisplayName("Dark Mode")
            }
        }
    }
