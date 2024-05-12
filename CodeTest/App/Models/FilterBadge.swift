//
//  Created by Andy on 2024-05-09.
//

import Foundation

struct FilterBadge: Identifiable, Equatable {
    let id: String
    let name: String
    let imageUrl: URL?
}

extension FilterBadge {
    
    static var mock: FilterBadge {
        FilterBadge(id: "1",
                    name: "Top Rated",
                    imageUrl: URL(string: "https://food-delivery.umain.io/images/filter/filter_top_rated.png")
        )
    }
    
}

extension FilterBadge {
    init?(_ response: FilterResponse) {
        self.id = response.id
        self.name = response.name
        self.imageUrl = URL(string:response.imageUrl)
    }
}

