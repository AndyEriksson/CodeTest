//
//  DetailCard.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-09.
//

import SwiftUI

struct DetailCard: View {
    
    let model: DetailCardModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(12, corners: .allCorners)
                .foregroundColor(.cardBackground)
                .shadow(color: .shadow, radius: 4, x: 0, y: 4)
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(model.title)
                        .foregroundStyle(.darkText)
                        .font(.customheadline1)
                    Text(model.tags.formattedTags)
                        .foregroundStyle(.subtitle)
                        .font(.customheadline2)
                    Text(model.status.text)
                        .font(.customtitle1)
                        .foregroundStyle(model.status.color)
                }
                .padding(16)
                
                Spacer()
            }
        }
    }
}

#Preview {
    DetailCard(model: .init(title: "Andys gryma fik", tags: .mock, status: .open))
        .fixedSize()
}
