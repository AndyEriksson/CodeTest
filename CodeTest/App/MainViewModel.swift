//
//  MainViewModel.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-09.
//

import Combine
import SwiftUI

class MainViewModel: ObservableObject {
    private let networkService: NetworkService
    @Published var restaurants: [Restaurant] = []
    @Published var selectedRestaurant: Restaurant?
    @Published var filterBadge: [String: FilterBadge] = [:]
    @Published var selectedBadgeId: String?
    @Published var isPresented = false
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    @MainActor
    func fetchRestaurants() async {
        let result = await networkService.getRestaurantsWithOpenStatus()
        switch result {
        case .success(let restaurantsResponse):
            self.restaurants = restaurantsResponse.restaurants
            await fetchFilterDetails(for: restaurantsResponse.restaurants)
        case .failure(let error):
            print("Failed to fetch restaurants: \(error)")
        }
    }
    
    @MainActor
    private func fetchFilterDetails(for restaurants: [Restaurant]) async {
        var filterIDs = Set<String>()
        for restaurant in restaurants {
            filterIDs.formUnion(restaurant.filterIds) // TODO:
        }
        
        var filters: [String: FilterBadge] = [:]
        for id in filterIDs {
            let filterResult = await networkService.getFilter(with: id)
            switch filterResult {
            case .success(let filterBadge):
                filters[id] = filterBadge
            case .failure(let error):
                print("Failed to fetch filter with ID \(id): \(error)")
            }
        }
        
        self.filterBadge = filters
    }
    
    func selectRestaurant(_ restaurant: Restaurant) {
        selectedRestaurant = restaurant
        isPresented = true
    }
    
    func selectBadge(with id: String) {
        selectedBadgeId = id
    }
}

extension MainViewModel {
    var filterBadgesArray: [FilterBadge] {
        filterBadge.map { $1 }
    }
}
