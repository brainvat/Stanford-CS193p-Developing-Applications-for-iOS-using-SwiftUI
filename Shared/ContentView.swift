//
//  ContentView.swift
//  Shared
//
//  Created by Allen Hammock on 8/5/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .stroke(lineWidth: 3)
            VStack {
                Text("Hello, CS103p!")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                Text("Welcome")
                    .font(.title2)
            }
            .multilineTextAlignment(.center)
        }
        .padding(.horizontal)
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
