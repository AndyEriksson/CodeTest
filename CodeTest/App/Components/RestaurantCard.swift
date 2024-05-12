//
//  Created by Andy on 2024-05-08.
//

import SwiftUI

struct RestaurantCard: View {
    
    let model: Restaurant
    
    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: model.imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: 132)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(model.name)
                        .textStyle(font: .title1)
                    Text(model.formattedFilterNames)
                        .textStyle(font: .subtitle1, color: .subtitle)
                    HStack(spacing: 3) {
                        Image(.clock)
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundStyle(.clock)
                            .padding(.vertical, 1)
                        Text("\(model.deliveryTimeMinutes) mins")
                            .textStyle(font: .footer1)
                    }
                }
                .padding(.leading, 8)
                .padding(.bottom, 8)
                Spacer()
                
                HStack(spacing: 3) {
                    Image(.star)
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.star)
                    Text("\(model.formattedRating)")
                        .textStyle(font: .footer1)
                }
                .padding(.trailing, 8)
            }
        }
        .background(Color.cardBackground)
        .cornerRadius(12, corners: [.topLeft, .topRight])
        .shadow(color: .shadow, radius: 4, x: 0, y: 4)
    }
}

#Preview {
    RestaurantCard(model: .mock)
    .fixedSize()
}
