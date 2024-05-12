//
//  ResturantCard.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-08.
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
                        .foregroundStyle(.darkText)
                        .font(.customtitle1)
                    Text("N/A")
                        .foregroundStyle(.subtitle)
                        .font(.customsubtitle1)
                    HStack(spacing: 3) {
                        Image(.clock)
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundStyle(.clock)
                            .padding(.vertical, 1)
                        Text("\(model.deliveryTimeMinutes) mins")
                            .foregroundStyle(.darkText)
                            .font(.customfooter1)
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
                        .font(.customfooter1)
                        .foregroundColor(.primary)
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
    RestaurantCard(model:
            .init(id: "1",
                  name: "Andy's fik",
                  filterIds: ["2", "3", "4"],
                  imageUrl: URL(string: "https://food-delivery.umain.io/images/restaurant/burgers.png")!,
                  rating: 3.6,
                  deliveryTimeMinutes: 29)
    )
    .fixedSize()
}
