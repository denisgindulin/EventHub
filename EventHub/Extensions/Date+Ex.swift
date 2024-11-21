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
    
    func formattedDate2() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current // Используем текущую локаль устройства
        formatter.dateFormat = "dd MMMM, yyyy"
        return formatter.string(from: self)
    }
    
    private func daySuffix() -> String {
            let calendar = Calendar.current
            let day = calendar.component(.day, from: self)
            
            switch day {
            case 11, 12, 13:
                return "th"
            default:
                switch day % 10 {
                case 1:
                    return "st"
                case 2:
                    return "nd"
                case 3:
                    return "rd"
                default:
                    return "th"
                }
            }
        }
        
        func formattedWithSuffix() -> String {
            let calendar = Calendar.current
            let day = calendar.component(.day, from: self)
            let suffix = daySuffix()
            
            let monthFormatter = DateFormatter()
            monthFormatter.locale = Locale.current
            monthFormatter.dateFormat = "MMMM" // "MMM" для сокращенного
            let monthString = monthFormatter.string(from: self)
            
            let weekdayFormatter = DateFormatter()
            weekdayFormatter.locale = Locale.current
            weekdayFormatter.dateFormat = "E" // "EEEE" для полного названия
            let weekdayString = weekdayFormatter.string(from: self)
            
            let timeFormatter = DateFormatter()
            timeFormatter.locale = Locale.current
            timeFormatter.dateFormat = "h:mm a" // "H:mm" для 24-часового формата
            let timeString = timeFormatter.string(from: self)
            
            return "\(day)\(suffix) \(monthString) - \(weekdayString) - \(timeString)"
        }
}
