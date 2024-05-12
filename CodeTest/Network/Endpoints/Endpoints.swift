//
//  Created by Andy on 2024-05-09.
//

import Foundation

enum Endpoints {
    case restaurants
    case filter(id: String)
    case open(id: String)
    
    private static let basePath = "/api/v1"
}

extension Endpoints: Endpoint {
    var path: String {
        switch self {
        case .restaurants:
            "\(Endpoints.basePath)/restaurants"
        case .filter(let id):
            "\(Endpoints.basePath)/filter/\(id)"
        case .open(let id):
            "\(Endpoints.basePath)/open/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .filter, .open, .restaurants:
            .get
        }
    }
    
    var header: [String : String]? {
        nil
    }
    
    var body: [String : String]? {
        nil
    }
}
