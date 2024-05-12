//
//  Created by Andy on 2024-05-09.
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
    DetailView(model:.mock)
}
