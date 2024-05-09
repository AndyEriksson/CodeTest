//
//  SwiftUIView.swift
//  CodeTest
//
//  Created by Andy  on 2024-05-09.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            VStack(alignment: .center, spacing: 0) {
                Image(.test)
                    .resizable()
                    .frame(height: 220)
                    .scaledToFit()
                
                DetailCard(model: .init(title: "Andy's crab shack", tags: .mock, status: .open))
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
    DetailView()
}
