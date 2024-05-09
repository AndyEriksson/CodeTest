//
//  ResturantCardModel.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-09.
//

import Foundation

struct ResturantCardModel: Hashable {
    
    let title: String
    let tags: Tags
    let rating: Double
    
}

extension ResturantCardModel {
    
    var formattedRating: String {
        String(format: "%.1f", rating)
    }
    
}
