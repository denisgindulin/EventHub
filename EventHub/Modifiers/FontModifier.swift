//
//  FontModifier.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 18.11.2024.
//

import SwiftUI

struct AirbnbCerealFontModifier: ViewModifier {
    let type: AirbnbCerealFont
    let size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom(type.rawValue, size: size))
    }
}
