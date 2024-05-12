//
//  Created by Andy on 2024-05-09.
//

import SwiftUI

struct FilterBadgeView: View {
    
    let model: FilterBadge
    
    var isSelected: Bool = false
    
    var body: some View {
        
        ZStack {
            Capsule(style: .circular)
                .foregroundColor(isSelected ? .selected : .badgeBackground)
                .shadow(color: .badgeShadow, radius: 10, x: 0, y: 4)
            
            HStack(alignment: .center, spacing: 8) {
                AsyncImage(url: model.imageUrl) { image in
                    image
                } placeholder: {
                    ProgressView()
                }
                
                Text(model.name)
                    .foregroundStyle(.darkText)
                    .font(.customtitle2)
                    .padding(.trailing, 16)
            }
        }
        .frame(height: 48)
    }
}

#Preview {
    FilterBadgeView(model: .mock)
        .fixedSize()
}
