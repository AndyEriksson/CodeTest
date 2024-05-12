//
//  Created by Andy on 2024-05-09.
//

import SwiftUI

class MainViewModel: ObservableObject {
    
    private let networkService: NetworkService
    
    @Published var allRestaurants: [Restaurant] = []
    @Published var filteredRestaurants: [Restaurant] = []
    @Published var filterBadge: [String: FilterBadge] = [:]
    @Published var selectedBadgeId: String?
    @Published var selectedRestaurant: Restaurant?
    @Published var isPresented = false
    
    @Published var errorMessage: String?
    @Published var showingAlert = false
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    @MainActor
    func fetchRestaurants() async {
        let result = await networkService.getRestaurantsWithOpenStatus()
        switch result {
        case .success(let restaurantsResponse):
            self.allRestaurants = restaurantsResponse.restaurants
            await fetchFilterDetails(for: restaurantsResponse.restaurants)
            applyFilter()
        case .failure(let error):
            errorMessage = "Failed to fetch restaurants: \(error.localizedDescription)"
            showingAlert = true
        }
    }
    
    @MainActor
    private func fetchFilterDetails(for restaurants: [Restaurant]) async {
        var filterIDs = Set(restaurants.flatMap { $0.filterIds })
        var filters: [String: FilterBadge] = [:]
        var errors: [Error] = []
        
        await withTaskGroup(of: (String, Result<FilterBadge, Error>).self) { [weak self] group in
            guard let self else { return }
            for id in filterIDs {
                group.addTask {
                    do {
                        let badge = try await self.networkService.getFilter(with: id).get()
                        return (id, .success(badge))
                    } catch {
                        return (id, .failure(error))
                    }
                }
            }
            
            for await (id, result) in group {
                switch result {
                case .success(let badge):
                    filters[id] = badge
                case .failure(let error):
                    errors.append(error)
                    print("Error fetching filter for ID \(id): \(error)")
                }
            }
        }
        
        self.filterBadge = filters
        
        if !errors.isEmpty {
            errorMessage = "Failed to fetch all filter details."
            showingAlert = true
        }
    }
    
    private func applyFilter() {
        guard let filterId = selectedBadgeId else {
            filteredRestaurants = allRestaurants
            return
        }
        filteredRestaurants = allRestaurants.filter { $0.filterIds.contains(filterId)}
        
    }
    
    func selectRestaurant(_ restaurant: Restaurant) {
        selectedRestaurant = restaurant
        isPresented = true
    }
    
    func selectBadge(with id: String) {
        if selectedBadgeId == id {
            selectedBadgeId = nil
        } else {
            selectedBadgeId = id
        }
        applyFilter()
    }
    
    func resetErrorState() {
        showingAlert = false
        errorMessage = nil
    }
}

extension MainViewModel {
    var filterBadgesArray: [FilterBadge] {
        filterBadge.map { $1 }
    }
}
