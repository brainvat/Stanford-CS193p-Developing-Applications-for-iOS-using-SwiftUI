//
//  ContentView.swift
//  Shared
//
//  Created by Allen Hammock on 8/5/21.
//

import SwiftUI

struct ContentView: View {
    var faces = ["🛩", "🚗", "⛵️", "🚝", "🛻", "🚠", "🦼", "🛵", "🚛", "🚓", "🛳", "🚛", "🚓", "🚓", "🛳", "🚛"]
    var facesPerRow = 3
    @State var faceCount = 6
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(0..<(1+(faces.count / facesPerRow)), id: \.self) { row in
                    HStack {
                        ForEach(0..<facesPerRow, id: \.self) { col in
                            let index = row*facesPerRow + col
                            
                            if index >= min(faceCount, faces.count) {
                                CardView(isBlank: true)
                            } else {
                                CardView(content: faces[index])
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
            HStack {
                removeButton
                Spacer()
                Text ("Reveal")
                Spacer()
                addButton

            }.font(.title).padding(.horizontal)
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
            faceCount = min(faces.count, faceCount + 1)
        } label: {
            Image(systemName: "plus.square")
        }
    }
}
struct CardView: View {
    var content: String = ""
    var isBlank: Bool = false
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            
            if isBlank {
                shape.fill().opacity(0.0)
            } else {
                if isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: 3)
                    VStack {
                        Text(content)
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .padding()
                        Text("Zoom!")
                            .font(.subheadline)
                    }
                } else {
                    shape.fill()
                }
            }

        }
        .multilineTextAlignment(.center)
        .aspectRatio(2/3, contentMode: .fit)
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
