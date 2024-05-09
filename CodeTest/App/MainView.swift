//
//  MainView.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-07.
//

import SwiftUI

struct MainView: View {
    
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
    @State private var isPresented = false
    
    var body: some View {
        VStack(spacing: 16) {
            Header()
            badgesView
            cardsView
        }
    }
    
    private var badgesView: some View {
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
    }
    
    private var cardsView: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(model, id: \.self) { item in
                    ResturantCard(model: item)
                        .onTapGesture {
                            isPresented.toggle()
                        }
                        .fullScreenCover(isPresented: $isPresented, content: {
                            DetailView()
                        })
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
}

#Preview {
    MainView()
}
