//
//  Created by Andy on 2024-05-12.
//

import SwiftUI

struct TextStyleModifier: ViewModifier {
    var font: Font.CustomFontType
    var foregroundColor: Color

    func body(content: Content) -> some View {
        content
            .font(font.font())
            .foregroundColor(foregroundColor)
            .customLineHeight(max(0, font.fontDetails.lineHeight - font.fontDetails.size))
    }
}

struct CustomLineHeightModifier: ViewModifier {
    var lineHeight: CGFloat
    var alignment: VerticalAlignment
    
    func body(content: Content) -> some View {
        content
            .frame(minHeight: lineHeight, alignment: Alignment(horizontal: .leading, vertical: alignment))
    }
}

private extension View {
    func customLineHeight(_ height: CGFloat, alignment: VerticalAlignment = .center) -> some View {
        self.modifier(CustomLineHeightModifier(lineHeight: height, alignment: alignment))
    }
}
