//
//  Created by Andy on 2024-05-09.
//

import SwiftUI

struct Restaurants {
    var restaurants: [Restaurant]
}

struct Restaurant: Identifiable, Equatable {
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String
    var name: String
    var filterIds: [String]
    var filterBadges: [FilterBadge] = []
    var imageUrl: URL?
    var rating: Double
    var deliveryTimeMinutes: Int
    var isOpen: Status?
}

extension Restaurants {
    init?(_ response: RestaurantsResponse, isOpen: Restaurant.Status? = nil) {
        self.restaurants = response.restaurants.map { restaurant in
            Restaurant(
                id: restaurant.id,
                name: restaurant.name,
                filterIds: restaurant.filterIds,
                imageUrl: URL(string: restaurant.imageUrl),
                rating: restaurant.rating,
                deliveryTimeMinutes: restaurant.deliveryTimeMinutes,
                isOpen: isOpen
            )
        }
    }
}

extension Restaurant {
    
    var formattedRating: String {
        String(format: "%.1f", rating)
    }
    
    var formattedFilterNames: String {
        filterBadges.map { $0.name }.joined(separator: " • ")
    }
    
    enum Status: String {
        case open = "Open"
        case closed = "Closed"
        
        var text: String {
            self.rawValue
        }
        
        var color: Color {
            switch self {
            case .open:
                    .positive
            case .closed:
                    .negative
            }
        }
    }
    
    static func status(from isOpen: Bool?) -> Status? {
        guard let isOpen = isOpen else {
            return nil
        }
        return isOpen ? .open : .closed
    }
    
    static var mock: Restaurant {
        Restaurant(
            id: "1",
            name: "Wayne's Smelly Eggs",
            filterIds: ["1", "2", "3"],
            imageUrl: URL(string: "https://food-delivery.umain.io/images/restaurant/burgers.png")!,
            rating: 4.8,
            deliveryTimeMinutes: 25,
            isOpen: .closed
        )
    }
    
}
