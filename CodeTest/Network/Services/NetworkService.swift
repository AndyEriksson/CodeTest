//
//  NetworkService.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-09.
//

import Foundation

protocol NetworkServiceProtocol {
    func getFilter(with id: String) async -> Result<FilterResponse, RequestError>
    func getRestaurants() async -> Result<Resturants, RequestError>
    func getOpenStatus(with id: String) async -> Result<OpenStatusResponse, RequestError>
}

struct NetworkService: HTTPClient, NetworkServiceProtocol {
    func getFilter(with id: String) async -> Result<FilterResponse, RequestError> {
        await sendRequest(endpoint: Endpoints.filter(id: id), responseModel: FilterResponse.self)
    }
    
    func getRestaurants() async -> Result<Resturants, RequestError> {
        switch await sendRequest(endpoint: Endpoints.restaurants, responseModel: RestaurantsResponse.self) {
        case .success(let response):
            if let resturants = Resturants(response) {
                return .success(resturants)
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
}
