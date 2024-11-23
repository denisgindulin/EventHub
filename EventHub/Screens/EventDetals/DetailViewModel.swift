//
//  DetailViewModel.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 21.11.2024.
//

import Foundation

struct DetailActions {
    let closed: CompletionBlock
}

final class DetailViewModel: ObservableObject {
    
    private let eventID: Int
    private let eventService: IEventAPIServiceForDetail
    
    @Published var event: EventDTO?
    @Published var errorMessage: String?
    
    // Вычисляемые свойства для удобства использования во View
    var title: String {
        event?.title?.capitalized ?? "Нет заголовка"
    }
    
    var description: String {
        event?.description?.htmlToString ?? "Нет описания"
    }
    
    var bodyText: String {
        event?.bodyText?.htmlToString ?? "Нет описания"
    }
    
    var startDate: String {
        guard let startTimestamp = event?.dates?.first?.start else { return "" }
        let date = Date(timeIntervalSince1970: TimeInterval(startTimestamp))
        return date.formattedDate(format: "dd MMMM, yyyy")
    }
    
    var endDate: String {
        guard let endTimestamp = event?.dates?.first?.end else { return "" }
        let date = Date(timeIntervalSince1970: TimeInterval(endTimestamp))
        return date.formattedDate(format: "E, MMM d • h:mm a")
    }
    
    var agentTitle: String {
        event?.participants?.first?.agent?.title ?? "No Name"
    }
    
    var role: String {
        event?.participants?.first?.role?.slug ?? "No Role"
    }
    
//    MARK: - Init
    init(eventID: Int, eventService: IEventAPIServiceForDetail) {
        self.eventID = eventID
        self.eventService = eventService
    }
    
    // Функция для получения деталей события
    func fetchEventDetails() async {
        do {
            let fetchedEvent = try await eventService.getEventDetails(eventID: eventID)
            self.event = fetchedEvent
        } catch {
            self.errorMessage = "Не удалось загрузить событие: \(error.localizedDescription)"
            print("Ошибка при получении события: \(error.localizedDescription)")
        }
    }

    let imageUrl = URL(string: "https://images.unsplash.com/photo-1731921954767-8473de81c99e?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwzfHx8ZW58MHx8fHx8")
    let adress = "36 Guild Street London, UK"
}
