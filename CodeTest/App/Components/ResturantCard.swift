//
//  ResturantCard.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-08.
//

import SwiftUI

struct ResturantCardModel: Hashable {
    let title: String
    let tags: [String]
    let rating: Double
}

extension ResturantCardModel {
    var formattedTags: String {
        tags.joined(separator: " • ")
    }
    
    var formattedRating: String {
        String(format: "%.1f", rating)
    }
}

struct ResturantCard: View {
    
    let model: ResturantCardModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.background.shadow(.drop(color: .shadow, radius: 4, x: 0, y: 4)))
                
            
            VStack(spacing: 8) {
                Image(.test)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 132)
                    .clipped()
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(model.title)
                            .foregroundStyle(.darkText)
                            .font(.customtitle1)
                        Text(model.formattedTags)
                            .foregroundStyle(.subtitle)
                            .font(.customsubtitle1)
                        HStack(spacing: 3) {
                            Image(systemName: "clock")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(.red) // TODO: Ask design if #FF5252 a color that is missing in Figma or if I should add it
                                .padding(.vertical, 1)
                            Text("30 mins")
                                .foregroundStyle(.darkText)
                                .font(.customfooter1)
                        }
                    }
                    .padding(.leading, 8)
                    .padding(.bottom, 8)
                    Spacer()
                    
                    HStack(spacing: 3) {
                        Image(systemName: "star.fill") // TODO: Where do I get this icon?
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.yellow) // TODO: Ask design if #F9CA24 a color that is missing in Figma
                        Text("\(model.formattedRating)")
                            .font(.customfooter1)
                            .foregroundColor(.primary)
                        
                    }
                    .padding(.trailing, 8)
                }
            }
            .cornerRadius(12, corners: [.topLeft, .topRight])
        }
        
    }
}

#Preview {
    ResturantCard(model: .init(title: "Andy's grymma fik", tags: ["breakfest","Party","Cookies"], rating: 3.6))
}
