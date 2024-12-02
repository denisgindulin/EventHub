//
//  View+Ex.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 18.11.2024.
//

import SwiftUI

extension View {
    func airbnbCerealFont(_ type: AirbnbCerealFont, size: CGFloat = 16) -> some View {
        modifier(AirbnbCerealFontModifier(type: type, size: size))
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func navigationLink<T: View>(
        destination: T,
        isActive: Binding<Bool>
    ) -> some View {
        overlay(
            NavigationLink(
                destination: destination,
                isActive: isActive
            ) {
                EmptyView()
            }
        )
    }
    
}
