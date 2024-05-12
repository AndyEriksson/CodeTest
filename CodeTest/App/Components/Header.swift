//
//  Created by Andy on 2024-05-09.
//

import SwiftUI

struct Header: View {
    
    private var isLoading = false
    @State private var logoWidth: CGFloat = 0.0
    
    init(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Image(.logo)
                .padding(.leading, Points.x2)
                .background(GeometryReader { imageGeometry in
                    Color.clear
                        .onAppear {
                            logoWidth = imageGeometry.size.width
                        }
                })
            Spacer()
            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(1.5)
                    .offset(x: -logoWidth / 2)
                Spacer()
            }
        }
    }
}

#Preview {
    Header(isLoading: true)
}
