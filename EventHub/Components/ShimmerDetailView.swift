//
//  ShimmerDetailView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 29.11.2024.
//

import SwiftUI

struct ShimmerDetailView: View {
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 50)
                .foregroundStyle(.fieldGray)
            VStack {
                RoundedRectangle(cornerRadius: 30)
                    .frame(height: 244)
                    .padding(20)
                    .foregroundStyle(.appLightGray)
                    .shimmering()
                
                VStack(alignment: .leading, spacing: 20) {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(.appLightGray)
                        .frame(height: 100)
                        .shimmering()
                        
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(.appLightGray)
                        .frame(width: 250,height: 90)
                        .shimmering()
                    
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(.appLightGray)
                        .frame(width: 250,height: 90)
                        .shimmering()
                    
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(.appLightGray)
                        .frame(width: 250,height: 90)
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
    ShimmerDetailView()
}
