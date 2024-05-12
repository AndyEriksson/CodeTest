//
//  Created by Andy on 2024-05-09.
//

import Combine
import SwiftUI

class MainViewModel: ObservableObject {
    
    private let networkService: NetworkService
    
    @Published var allRestaurants: [Restaurant] = []
    @Published var filteredRestaurants: [Restaurant] = []
    @Published var filterBadge: [String: FilterBadge] = [:]
    @Published var selectedBadgeId: String?
    @Published var selectedRestaurant: Restaurant?
    @Published var isPresented = false
    
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
            print("Failed to fetch restaurants: \(error)")
        }
    }
    
    @MainActor
    private func fetchFilterDetails(for restaurants: [Restaurant]) async {
        var filterIDs = Set(restaurants.flatMap { $0.filterIds })
            var filters: [String: FilterBadge] = [:]
            
            await withTaskGroup(of: (String, FilterBadge?).self) { [weak self] group in
                guard let self else { return }
                for id in filterIDs {
                    group.addTask {
                        let result = await self.networkService.getFilter(with: id)
                        return (id, try? result.get())
                    }
                }
                
                for await (id, badge) in group {
                    if let badge = badge {
                        filters[id] = badge
                    }
                }
            }
            
            self.filterBadge = filters
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
}

extension MainViewModel {
    var filterBadgesArray: [FilterBadge] {
        filterBadge.map { $1 }
    }
}
