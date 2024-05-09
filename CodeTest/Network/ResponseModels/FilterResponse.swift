//
//  FilterResponse.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-09.
//

import Foundation

struct FilterResponse: Decodable {
    var id: String
    var name: String
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "image_url"
    }
}
