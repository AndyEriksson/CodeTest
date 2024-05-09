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
                updatedRestaurants.append(restaurant)
            }
            
            return .success(Restaurants(restaurants: updatedRestaurants))
            
        case .failure(let error):
            return .failure(error)
        }
    }

}
