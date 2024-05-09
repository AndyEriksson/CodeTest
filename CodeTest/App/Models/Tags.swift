//
//  TagsModel.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-09.
//

import Foundation

struct Tags: Hashable {
    
    let tags: [String]
    
}

extension Tags {
    
    var formattedTags: String {
        tags.joined(separator: " • ")
    }
    
    static var mock: Tags {
        .init(tags: ["Take-Out", "Fast Delivery", "Eat in"])
    }
    
}
