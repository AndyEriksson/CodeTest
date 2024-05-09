//
//  SwiftUIView.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-09.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let model: Restaurant
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            VStack(alignment: .center, spacing: 0) {
                AsyncImage(url: model.imageUrl) { image in
                    image
                        .resizable()
                        .frame(height: 220)
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                
                DetailCard(model: model)
                    .padding(.horizontal, 16)
                    .offset(y: -45)
                
                Rectangle()
                    .foregroundColor(.clear)
                
            }
            .foregroundColor(.background)
            .ignoresSafeArea()
            
            Button(action: {
                dismiss()
            }, label: {
                Image(.chevron)
            })
            .padding(.leading, 22)
        }
        
    }
}

#Preview {
    DetailView(model:
            .init(id: "1",
                  name: "Andy's fik",
                  filterIds: ["2", "3", "4"],
                  imageUrl: URL(string: "https://food-delivery.umain.io/images/restaurant/burgers.png")!,
                  rating: 3.6,
                  deliveryTimeMinutes: 29,
                  isOpen: .open)
    )
}
