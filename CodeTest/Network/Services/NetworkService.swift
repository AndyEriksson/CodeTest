//
//  NetworkService.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-09.
//

import Foundation

protocol NetworkServiceProtocol {
    func getFilter(with id: String) async -> Result<FilterBadge, RequestError>
    func getRestaurants() async -> Result<Restaurants, RequestError>
    func getOpenStatus(with id: String) async -> Result<OpenStatusResponse, RequestError>
}

struct NetworkService: HTTPClient, NetworkServiceProtocol {
    
    func getFilter(with id: String) async -> Result<FilterBadge, RequestError> {
        switch await sendRequest(endpoint: Endpoints.filter(id: id), responseModel: FilterResponse.self) {
        case .success(let response):
            if let filter = FilterBadge(response) {
                return .success(filter)
            } else {
                return .failure(.decode)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getRestaurants() async -> Result<Restaurants, RequestError> {
        switch await sendRequest(endpoint: Endpoints.restaurants, responseModel: RestaurantsResponse.self) {
        case .success(let response):
            if let restaurants = Restaurants(response) {
                return .success(restaurants)
            } else {
                return .failure(.decode)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getOpenStatus(with id: String) async -> Result<OpenStatusResponse, RequestError> {
        await sendRequest(endpoint: Endpoints.open(id: id), responseModel: OpenStatusResponse.self)
    }
    
    func getRestaurantsWithOpenStatus() async -> Result<Restaurants, RequestError> {
        switch await getRestaurants() {
        case .success(let restaurantsResponse):
            var updatedRestaurants: [Restaurant] = []
            
            for var restaurant in restaurantsResponse.restaurants {
                let statusResult = await getOpenStatus(with: restaurant.id)
                switch statusResult {
                case .success(let openStatusResponse):
                    restaurant.isOpen = Restaurant.status(from: openStatusResponse.isCurrentlyOpen)
                case .failure(let error):
                    print("Failed to fetch open status for restaurant ID \(restaurant.id): \(error)")
                    restaurant.isOpen = nil
                }

                // Fetch filter badges asynchronously and handle them
                let badgeResults = await fetchBadges(for: restaurant.filterIds)
                restaurant.filterBadges = badgeResults.compactMap { result in
                    switch result {
                    case .success(let badge):
                        return badge
                    case .failure(let error):
                        print("Failed to fetch badge: \(error)")
                        return nil
                    }
                }
                
                updatedRestaurants.append(restaurant)
            }
            
            return .success(Restaurants(restaurants: updatedRestaurants))
            
        case .failure(let error):
            return .failure(error)
        }
    }

    private func fetchBadges(for filterIds: [String]) async -> [Result<FilterBadge, RequestError>] {
        await withTaskGroup(of: Result<FilterBadge, RequestError>.self) { group in
            for id in filterIds {
                group.addTask {
                    return await self.getFilter(with: id)
                }
            }
            return await group.reduce(into: []) { $0.append($1) }
        }
    }
    
}
