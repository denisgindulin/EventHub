//
//  Date+Ex.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 20.11.2024.
//

import Foundation

extension Date {
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current // Используем текущую локаль устройства
        formatter.dateFormat = "E, MMM d • h:mm a"
        return formatter.string(from: self)
    }
}
