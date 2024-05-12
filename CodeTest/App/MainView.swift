//
//  Created by Andy on 2024-05-07.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Header()
            badgesView
            cardsView
        }
        .background(Color.background)
        .onAppear {
            Task {
                await viewModel.fetchRestaurants()
            }
        }
    }
    
    private var badgesView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Points.x2) {
                ForEach(viewModel.filterBadgesArray) { badge in
                    FilterBadgeView(model: badge, isSelected: badge.id == viewModel.selectedBadgeId)
                        .onTapGesture {
                            viewModel.selectBadge(with: badge.id)
                        }
                }
            }
            .padding(.horizontal, Points.x2)
            .padding(.top, Points.x2)
            .padding(.bottom, Points.x3)
        }
    }
    
    private var cardsView: some View {
        ScrollView {
            VStack(spacing: Points.x2) {
                ForEach(viewModel.filteredRestaurants) { model in
                    RestaurantCard(model: model)
                        .onTapGesture {
                            viewModel.selectRestaurant(model)
                        }
                }
            }
            .padding(.horizontal, Points.x2)
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
