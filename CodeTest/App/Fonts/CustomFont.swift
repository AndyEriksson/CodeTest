//
//  Created by Andy on 2024-05-07.
//

import SwiftUI

extension Font {
    
    enum CustomFontType: String {
        case title1
        case title2
        case subtitle1
        case footer1
        case headline1
        case headline2
        
        var fontDetails: (name: String, size: CGFloat, weight: Font.Weight, lineHeight: CGFloat) {
            switch self {
            case .title1:
                return ("Helvetica", 18, .regular, 16)
            case .title2:
                return ("Poppins-Medium", 14, .regular, 20)
            case .subtitle1:
                return ("Helvetica", 12, .bold, 16)
            case .footer1:
                return ("Inter-Medium", 10, .regular, 12.1)
            case .headline1:
                return ("Helvetica", 24, .regular, 16)
            case .headline2:
                return ("Helvetica", 16, .regular, 16)
            }
        }
        
        func font() -> Font {
            .custom(fontDetails.name, size: fontDetails.size).weight(fontDetails.weight)
        }
    }
    
    static func customFont(_ type: CustomFontType) -> Font {
        type.font()
    }
}
