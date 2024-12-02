//
//  ShimmerDetailView.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 02.12.2024.
//

import SwiftUI

struct ShimmerEventView: View {
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 50)
                .foregroundStyle(.fieldGray)
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(.appLightGray)
                    .frame(height: 100)
                    .shimmering()
                
                RoundedRectangle(cornerRadius: 30)
                    .frame(height: 300)
                    .padding(20)
                    .foregroundStyle(.appLightGray)
                    .shimmering()
                
                VStack(alignment: .leading, spacing: 20) {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(.appLightGray)
                        .frame(height: 100)
                        .shimmering()
                   
                }
                .padding(.horizontal,20)
                Spacer()
            }
            }
        .ignoresSafeArea()
    }
}

#Preview {
    ShimmerEventView()
}
