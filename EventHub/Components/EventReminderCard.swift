//
//  EventReminderCard.swift
//  EventHub
//
//  Created by Денис Гиндулин on 24.11.2024.
//

import SwiftUI

// это компонент Карточка напоминания о событии. Для экрана Notification. Содержит название события, текст "coming soon" и текст с количеством дней до начала события (или после него)
struct EventReminderCard: View {
    let eventTitle: String
    let daysNumberText: String
    
    var body: some View {
        VStack {
            HStack {
                Text(eventTitle + " coming soon!")
                    .airbnbCerealFont(.book, size: 16)
                    .foregroundStyle(.titleFont)
                    .frame(maxWidth: UIScreen.main.bounds.width * 253/375, alignment: .leading)
                Spacer()
            }
            .padding(.bottom, 1)
            HStack {
                Text(daysNumberText)
                    .airbnbCerealFont(.book, size: 14)
                    .foregroundStyle(Color(red: 124/255, green: 124/255, blue: 123/255))
                    .frame(maxWidth: UIScreen.main.bounds.width * 250/375, alignment: .leading)
                Spacer()
            }
        }
        .padding(UIScreen.main.bounds.width * 16/375)
        .background(Color(red: 251/255, green: 251/255, blue: 251/255))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .titleFont.opacity(0.1), radius: 2, x: 0, y: 3)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    Color(red: 237/255, green: 237/255, blue: 237/235), 
                    lineWidth: 1
                )
        )
    }
}

// компонент содержит одну карточку, но в Preview показано три карточки, чтобы было легче сравнить с дизайном в Figma, и подложен фон, чтобы легче воспринимать размеры карточек
#Preview {
    ZStack {
        Color.indigo.opacity(0.05).ignoresSafeArea()
        VStack {
            ForEach(0 ..< 3) { item in
                EventReminderCard(eventTitle: "International Band Music Concert", daysNumberText: "5 days ago")
            }
            .padding(.vertical, 8)
        }
        .padding(.horizontal, 16)
    }
}
