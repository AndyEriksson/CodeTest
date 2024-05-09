//
//  OpenStatusResponse.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-09.
//

import Foundation

struct OpenStatusResponse: Decodable {
    var restaurantId: String
    var isCurrentlyOpen: Bool
    
    enum CodingKeys: String, CodingKey {
        case restaurantId = "restaurant_id"
        case isCurrentlyOpen = "is_currently_open"
    }
}
