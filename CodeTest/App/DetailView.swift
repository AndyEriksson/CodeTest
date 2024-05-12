//
//  Created by Andy on 2024-05-09.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    private let model: Restaurant
    
    init(model: Restaurant) {
        self.model = model
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            VStack(alignment: .center, spacing: 0) {
                AsyncImage(url: model.imageUrl) { image in
                    image
                        .resizable()
                        .frame(height: 220)
                        .scaledToFit()
                } placeholder: {
                    ZStack {
                        Color.white
                            .frame(height: 220)
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .darkText))
                    }
                }
                
                DetailCard(model: model)
                    .padding(.horizontal, Points.x2)
                    .offset(y: -45)
                    .background(Color.background)
                
                Rectangle()
                    .foregroundColor(.background)
                
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
    DetailView(model:.mock)
}
