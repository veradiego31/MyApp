//
//  ContentView.swift
//  MyApp
//
//  Created by Diego Vera on 2023-09-26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text(Date(timeIntervalSince1970: 1696563619), style: .timer)
            .font(.system(size: 30, weight: .semibold, design: .rounded))
            .monospacedDigit()
            .contentTransition(.numericText())
            .transaction { transaction in
                transaction.animation = .snappy
            }
    }
}

#Preview {
    ContentView()
}
