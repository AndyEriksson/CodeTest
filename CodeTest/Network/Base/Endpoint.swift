//
//  Endpoint.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-09.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        "https"
    }
    
    var host: String {
        "food-delivery.umain.io"
    }
}
