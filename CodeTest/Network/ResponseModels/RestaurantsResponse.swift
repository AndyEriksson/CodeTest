//
//  RestaurantsResponse.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-09.
//

import Foundation

struct RestaurantsResponse: Decodable {
    var restaurants: [RestaurantResponse]
}

struct RestaurantResponse: Decodable {
    var filterIds: [String]
    var imageUrl: String
    var rating: Double
    var deliveryTimeMinutes: Int
    var id: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case filterIds
        case imageUrl = "image_url"
        case rating
        case deliveryTimeMinutes = "delivery_time_minutes"
        case id
        case name
    }
}
