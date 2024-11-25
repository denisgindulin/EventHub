//
//  TextOnlyButton.swift
//  EventHub
//
//  Created by Денис Гиндулин on 24.11.2024.
//

import SwiftUI

struct TextOnlyButton: View {
    let title: String
    let color: Color
    let font: AirbnbCerealFont
    let opacity: Double
    let titleFontSize: CGFloat
    let action: () -> Void
    
    init(title: String, color: Color = .appBlue, font: AirbnbCerealFont = .medium, opacity: Double = 1.0, titleFontSize: CGFloat = 18, action: () -> Void) {
        self.title = title
        self.color = color
        self.font = font
        self.opacity = opacity
        self.action = {}
        self.titleFontSize = titleFontSize
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .foregroundStyle(color.opacity(opacity))
                .airbnbCerealFont(font, size: CGFloat(titleFontSize))
        }
    }
}

#Preview {
    VStack {
        ZStack {
            Rectangle()
                .frame(width: 300, height: 100)
                .foregroundColor(.appBlue)
            
            HStack {
                TextOnlyButton(
                    title: "Skip",
                    color: .white,
                    font: .bold,
                    opacity: 0.5,
                    action: {}
                )
                
                TextOnlyButton(
                    title: "Next",
                    color: .white,
                    font: .bold,
                    action: {}
                )
            }
        }
        .padding()
        
        TextOnlyButton(
            title: "Read More",
            font: .book,
            titleFontSize: 16,
            action: {}
        )
        
        Divider()
        TextOnlyButton(
            title: "Sign Out",
            color: .black,
            font: .book,
            titleFontSize: 16,
            action: {}
        )
    }
}

