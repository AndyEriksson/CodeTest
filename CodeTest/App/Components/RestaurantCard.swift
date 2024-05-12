//
//  Created by Andy on 2024-05-08.
//

import SwiftUI

struct RestaurantCard: View {
    
    private let model: Restaurant
    
    init(model: Restaurant) {
        self.model = model
    }
    
    var body: some View {
        VStack(spacing: Points.x1) {
            AsyncImage(url: model.imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: 132)
                    .clipped()
            } placeholder: {
                ZStack {
                    Color.white
                        .frame(height: 132)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .darkText))
                }
            }
            
            detailStack
        }
        .background(Color.cardBackground)
        .cornerRadius(12, corners: [.topLeft, .topRight])
        .shadow(color: .shadow, radius: 4, x: 0, y: 4)
    }
    
    private var detailStack: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 2) {
                Text(model.name)
                    .textStyle(font: .title1)
                Text(model.formattedFilterNames)
                    .textStyle(font: .subtitle1, color: .subtitle)
                deliveryTimeStack
            }
            .padding(.leading, Points.x1)
            .padding(.bottom, Points.x1)
            Spacer()
            
            raitingStack
        }
    }
    
    private var deliveryTimeStack: some View {
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
    
    private var raitingStack: some View {
        HStack(spacing: 3) {
            Image(.star)
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundColor(.star)
            Text("\(model.formattedRating)")
                .textStyle(font: .footer1)
        }
        .padding(.trailing, Points.x1)
    }
}

#Preview {
    RestaurantCard(model: .mock)
    .fixedSize()
}
