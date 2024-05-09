//
//  ContentView.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-07.
//

import SwiftUI

struct ContentView: View {
    
    let model = [
        ResturantCardModel(title: "Test", tags: .mock, rating: 2.8),
        ResturantCardModel(title: "Test", tags: .mock, rating: 2.8),
        ResturantCardModel(title: "Test", tags: .mock, rating: 2.8),
        ResturantCardModel(title: "Test", tags: .mock, rating: 2.8)
    ]
    
    let badges = [
        FilterBadge.mock,
        FilterBadge.mock,
        FilterBadge.mock,
        FilterBadge.mock
    ]
    
    @State private var selectedBadgeId: String?
    
    var body: some View {
        VStack(spacing: 16) {
            
            Header()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(badges) { badge in
                        FilterBadgeView(model: badge, isSelected: badge.id == selectedBadgeId)
                            .onTapGesture {
                                selectedBadgeId = badge.id
                            }
                    }
                }
                .padding(.leading, 16)
            }
            
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
}

#Preview {
    ContentView()
}
