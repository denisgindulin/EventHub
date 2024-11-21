//
//  ThirdSmallEventCard.swift
//  EventHub
//
//  Created by Денис Гиндулин on 21.11.2024.
//

import SwiftUI

// это компонент Третья маленькая карточка события. Для экрана Lists. Содержит название события и кнопку READ для перехода к экрану с WebView (к статье о событии, открывающейся в веб-браузере)
struct ThirdSmallEventCard: View {
    let title: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .airbnbCerealFont(.medium, size: 16)
                    .foregroundStyle(.titleFont)
                    .frame(maxWidth: UIScreen.main.bounds.width * 250/375, alignment: .leading)
                Spacer()
            }
            HStack {
                BlueCapsuleButtonWithArrow(text: "READ") {
                    // TODO: здесь по нажатию на кнопку READ переход к WebView (к статье о событии, открывающейся в веб-браузере)
                }
                Spacer()
            }
        }
        .padding(16)
        .background(.appBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .titleFont.opacity(0.1), radius: 8, x: 0, y: 10)
    }
}


// компонент содержит одну карточку, но в Preview показано три карточки, чтобы было легче сравнить с дизайном в Figma, и подложен фон, чтобы легче воспринимать размеры карточек
#Preview {
    ZStack {
        Color.pink.opacity(0.05).ignoresSafeArea()
        VStack {
            ForEach(0 ..< 3) { item in
                ThirdSmallEventCard(title: "Jo Malone London’s Mother’s Day \nPresents")
            }
            .padding(.vertical, 8)
        }
        .padding(.horizontal, 16)
    }
}
