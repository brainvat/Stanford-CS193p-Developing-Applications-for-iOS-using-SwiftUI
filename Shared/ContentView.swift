//
//  ContentView.swift
//  Shared
//
//  Created by Allen Hammock on 8/5/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack (content: {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .stroke(lineWidth: 3)
                .padding()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            VStack {
                Text("Hello, CS103p!")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("Welcome")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.blue)
            }
        })
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
