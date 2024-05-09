//
//  CustomFont.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-07.
//

import SwiftUI

extension Font {
    
    // TODO: Add line height
    
    private static let helvetica = "Helvetica"
    private static let poppinsMedium = "Poppins-Medium"
    private static let interMedium = "Inter-Medium"
    
    static let customtitle1: Font = .custom(helvetica, size: 18).weight(.regular)
    static let customtitle2: Font = .custom(poppinsMedium, size: 14)
    static let customsubtitle1: Font = .custom(helvetica, size: 12).weight(.bold)
    static let customfooter1: Font = .custom(interMedium, size: 10)
    static let customheadline1: Font = .custom(helvetica, size: 24).weight(.regular)
    static let customheadline2: Font = .custom(helvetica, size: 16).weight(.regular)
}
