//
//  Created by Andy on 2024-05-07.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    @State private var contentOpacity = 0.0
    @State private var showContent = false
    
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 0) {
                Header(isLoading: viewModel.isLoading)
                if showContent {
                    badgesView
                        .opacity(contentOpacity)
                    cardsView
                        .opacity(contentOpacity)
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchRestaurants()
                    withAnimation {
                        showContent = true
                    }
                    try? await Task.sleep(nanoseconds: 500_000_000)
                    withAnimation(.easeInOut(duration: 0.5)) {
                        contentOpacity = 1.0
                    }
                }
            }
            .alert("Error", isPresented: $viewModel.showingAlert) {
                Button("Ok", role: .cancel) {
                    viewModel.resetErrorState()
                }
            } message: {
                Text(viewModel.errorMessage ?? "An unknown error occurred")
            }
        }
    }
    
    private var badgesView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Points.x2) {
                ForEach(viewModel.filterBadgesArray) { badge in
                    FilterBadgeView(model: badge, isSelected: viewModel.selectedBadgeIds.contains(badge.id))
                        .onTapGesture {
                            viewModel.selectBadge(with: badge.id)
                        }
                        .transition(.blurReplace)
                }
            }
            .padding(.horizontal, Points.x2)
            .padding(.top, Points.x2)
            .padding(.bottom, Points.x3)
            .animation(.easeInOut, value: viewModel.filterBadgesArray)
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
                        .transition(.blurReplace)
                }
            }
            .padding(.horizontal, Points.x2)
            .animation(.easeInOut, value: viewModel.filteredRestaurants)
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
