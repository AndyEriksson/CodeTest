//
//  Created by Andy on 2024-05-09.
//

import SwiftUI
import Kingfisher

struct FilterBadgeView: View {
    
    private let model: FilterBadge
    private var isSelected: Bool = false
    
    init(model: FilterBadge, isSelected: Bool) {
        self.model = model
        self.isSelected = isSelected
    }
    
    var body: some View {
        
        ZStack {
            Capsule(style: .circular)
                .foregroundColor(isSelected ? .selected : .white)
                .shadow(color: .badgeShadow, radius: 10, x: 0, y: 4)
            
            HStack(alignment: .center, spacing: Points.x1) {
                KFImage(model.imageUrl)
                    .placeholder {
                        Color.white
                            .clipShape(Circle())
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .darkText))
                    }
                    .resizable()
                    .frame(width: 48, height: 48)
                
                Text(model.name)
                    .textStyle(font: .title2)
                    .padding(.trailing, Points.x2)
            }
        }
        .frame(height: 48)
    }
}

#Preview {
    FilterBadgeView(model: .mock, isSelected: false)
        .fixedSize()
}
