//
//  FilterBadge.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-09.
//

import Foundation

struct FilterBadge: Identifiable {
    var id: String = UUID().uuidString
    let title: String
    let image: String // TODO: Fix this
}

extension FilterBadge {
    
    static var mock: FilterBadge {
        .init(title: "Top Rated", image: "medal")
    }
    
}
