//
//  MainView.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-07.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Header()
            badgesView
            cardsView
        }
        .onAppear {
            Task {
                await viewModel.fetchRestaurants()
            }
        }
    }
    
    private var badgesView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(viewModel.badges) { badge in
                    FilterBadgeView(model: badge, isSelected: badge.id == viewModel.selectedBadgeId)
                        .onTapGesture {
                            viewModel.selectBadge(with: badge.id)
                        }
                }
            }
            .padding(.leading, 16)
        }
    }
    
    private var cardsView: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(viewModel.restaurants) { item in
                    ResturantCard(model: item)
                        .onTapGesture {
                            viewModel.togglePresentation()
                        }
                        .fullScreenCover(isPresented: $viewModel.isPresented, content: {
                            DetailView()
                        })
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
}

#Preview {
    MainView(viewModel: MainViewModel(networkService: NetworkService()))
}
