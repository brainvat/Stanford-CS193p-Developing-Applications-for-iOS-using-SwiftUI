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
                
                AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                    CardView(card)
                        .padding(2)
                        .foregroundColor(card.color)
                        .onTapGesture {
                            game.choose(card)
                        }
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
            GeometryReader { geometry in
                ZStack {
                    let shape = RoundedRectangle(cornerRadius: CardDrawingConstants.cornerRadius)
                    
                    if card.isFaceUp {
                        shape.fill().foregroundColor(.white)
                        shape.strokeBorder(lineWidth: CardDrawingConstants.lineWidth)
                        Pie(startAngle: Angle(degrees: 0-90.0), endAngle: Angle(degrees: 110.0-90.0))
                            .padding(CardDrawingConstants.piePadding)
                            .opacity(CardDrawingConstants.pieOpacity)
                        Text(card.content)
                            .font(font(in: geometry.size))
                            .foregroundColor(.black)
                    } else if card.isMatched {
                        shape.opacity(0.0)
                    } else {
                        shape.fill()
                    }
                    
                }
                .multilineTextAlignment(.center)
            }
        }
        
        init(_ card: EmojiMemoryGame.Card) {
            self.card = card
        }
        
        private struct CardDrawingConstants {
            static let cornerRadius: CGFloat = 10
            static let lineWidth: CGFloat = 2
            static let fontScale: CGFloat = 0.5
            static let piePadding: CGFloat = 5
            static let pieOpacity: Double = 0.5
        }
        
        private func font(in size: CGSize) -> Font {
            Font.system(size: CardDrawingConstants.fontScale * min(size.width, size.height))
        }
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            let game = EmojiMemoryGame()
            game.choose(game.cards.first!)
            return Group {
                EmojiMemoryGameView(game)
                    .preferredColorScheme(.light)
                    .previewDisplayName("Light Mode")
                EmojiMemoryGameView(game)
                    .preferredColorScheme(.dark)
                    .previewDisplayName("Dark Mode")
            }
        }
    }
