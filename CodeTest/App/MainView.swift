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
                ForEach(viewModel.filterBadgesArray) { badge in
                    FilterBadgeView(model: badge, isSelected: badge.id == viewModel.selectedBadgeId)
                        .onTapGesture {
                            viewModel.selectBadge(with: badge.id)
                        }
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    private var cardsView: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(viewModel.filteredRestaurants) { model in
                    RestaurantCard(model: model)
                        .onTapGesture {
                            viewModel.selectRestaurant(model)
                        }
                }
            }
            .padding(.horizontal, 16)
        }
        .fullScreenCover(isPresented: $viewModel.isPresented, onDismiss: {
            viewModel.isPresented = false
        }) {
            if let selectedRestaurant = viewModel.selectedRestaurant {
                DetailView(model: selectedRestaurant)
            }
        }
    }
    
}

#Preview {
    MainView(viewModel: MainViewModel(networkService: NetworkService()))
}
