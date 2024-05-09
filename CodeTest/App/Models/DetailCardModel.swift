//
//  DetailCardModel.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-09.
//

import SwiftUI

struct DetailCardModel {
    
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
    
    let title: String
    let tags: Tags
    let status: Status
}
