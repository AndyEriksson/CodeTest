//
//  Created by Andy on 2024-05-09.
//

import SwiftUI

struct DetailCard: View {
    
    let model: Restaurant
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(12, corners: .allCorners)
                .foregroundColor(.cardBackground)
                .shadow(color: .shadow, radius: 4, x: 0, y: 4)
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 16) {
                    Text(model.name)
                        .textStyle(font: .headline1)
                    Text(model.formattedFilterNames)
                        .textStyle(font: .headline2, color: .subtitle)
                    Text(model.isOpen?.text ?? "")
                        .textStyle(font: .title1, color: model.isOpen?.color ?? .clear)
                }
                .padding(16)
                
                Spacer()
            }
        }
        .frame(height: 144)
    }
}

#Preview {
    DetailCard(model: .mock)
    .fixedSize()
}
