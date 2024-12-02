//
//  FirestoreError.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 02.12.2024.
//

import Foundation

enum FirestoreError: LocalizedError {
    case userNotAuthenticated
    case documentNotFound
    case fieldNotFound(fieldName: String)
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .userNotAuthenticated:
            return "Пользователь не аутентифицирован."
        case .documentNotFound:
            return "Документ пользователя не найден."
        case .fieldNotFound(let fieldName):
            return "Поле '\(fieldName)' не найдено в документе."
        case .unknownError:
            return "Неизвестная ошибка."
        }
    }
}
