//
//  ContentView.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-07.
//

import SwiftUI

struct ContentView: View {
    
    let model = [
        ResturantCardModel(title: "Test", tags: ["test", "mums"], rating: 2.8),
        ResturantCardModel(title: "Test", tags: ["test", "mums"], rating: 2.8),
        ResturantCardModel(title: "Test", tags: ["test", "mums"], rating: 2.8),
        ResturantCardModel(title: "Test", tags: ["test", "mums"], rating: 2.8)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(model, id: \.self) { item in
                    ResturantCard(model: item)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    ContentView()
}
