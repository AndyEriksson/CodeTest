//
//  Created by Andy on 2024-05-09.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack {
            Image(.logo)
                .padding(.leading, Points.x2)
            Spacer()
        }
        
    }
}

#Preview {
    Header()
}
