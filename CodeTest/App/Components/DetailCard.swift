//
//  DetailCard.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-09.
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
                VStack(alignment: .leading, spacing: 0) {
                    Text(model.name)
                        .foregroundStyle(.darkText)
                        .font(.customheadline1)
                    Text("N/A")
                        .foregroundStyle(.subtitle)
                        .font(.customheadline2)
                    Text(model.isOpen?.text ?? "")
                        .font(.customtitle1)
                        .foregroundStyle(model.isOpen?.color ?? .clear)
                }
                .padding(16)
                
                Spacer()
            }
        }
        .frame(height: 144)
    }
}

#Preview {
    DetailCard(model:
            .init(id: "1",
                  name: "Andy's fik",
                  filterIds: ["2", "3", "4"],
                  imageUrl: URL(string: "https://food-delivery.umain.io/images/restaurant/burgers.png")!,
                  rating: 3.6,
                  deliveryTimeMinutes: 29,
                  isOpen: .open)
    )
    .fixedSize()
}
