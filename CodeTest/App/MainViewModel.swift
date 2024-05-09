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
    @Published var selectedBadgeId: String?
    @Published var isPresented = false

    let badges = [
        FilterBadge.mock,
        FilterBadge.mock,
        FilterBadge.mock,
        FilterBadge.mock
    ]
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    @MainActor
    func fetchRestaurants() async {
        let result = await networkService.getRestaurants()
        switch result {
        case .success(let restaurantsResponse):
            self.restaurants = restaurantsResponse.restaurants
        case .failure(let error):
            print("Failed to fetch restaurants: \(error)")
        }
    }
    
    func togglePresentation() {
        isPresented.toggle()
    }
    
    func selectBadge(with id: String) {
        selectedBadgeId = id
    }
}

