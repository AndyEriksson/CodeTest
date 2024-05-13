//
//  Created by Andy on 2024-05-09.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    private let model: Restaurant
    
    init(model: Restaurant) {
        self.model = model
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            VStack(alignment: .center, spacing: 0) {
                KFImage(model.imageUrl)
                    .placeholder {
                        ZStack {
                            Color.white
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .darkText))
                        }
                    }
                    .resizable()
                    .frame(height: 220)
                    .scaledToFit()
                
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
