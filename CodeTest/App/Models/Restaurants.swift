//
//  Restaurants.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-09.
//

import Foundation

struct Resturants {
    var restaurants: [Restaurant]
}

struct Restaurant: Identifiable {
    var id: String
    var name: String
    var filterIds: [String]
    var imageUrl: URL?
    var rating: Double
    var deliveryTimeMinutes: Int
}

extension Resturants {
    init?(_ response: RestaurantsResponse) {
        self.restaurants = response.restaurants.map { response in
            Restaurant(
                id: response.id,
                name: response.name,
                filterIds: response.filterIds,
                imageUrl: URL(string: response.imageUrl),
                rating: response.rating,
                deliveryTimeMinutes: response.deliveryTimeMinutes
            )
        }
    }
}

extension Restaurant {
    
    var formattedRating: String {
        String(format: "%.1f", rating)
    }
    
}
