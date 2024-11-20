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
}
