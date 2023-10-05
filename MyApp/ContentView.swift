//
//  ContentView.swift
//  MyApp
//
//  Created by Diego Vera on 2023-09-26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, App!")
            }
            Text("this is description")
                .bold()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
