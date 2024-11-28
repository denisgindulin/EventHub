//
//  DetailViewModel.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 21.11.2024.
//

import Foundation

@MainActor
final class DetailViewModel: ObservableObject {
    
    private let eventID: Int
    private let eventService: IEventAPIServiceForDetail
    
    @Published var event: EventDTO? {
        didSet {
            self.updateTexts()
        }
    }
    
    @Published var bodyText: String = "Нет описания"
    @Published var descriptionText: String = "Нет описания"
    
    // Вычисляемые свойства для удобства использования во View
    var image: String? {
        return event?.images.first?.image
    }
    
    var title: String {
        event?.title?.capitalized ?? "Нет заголовка"
    }
    
    var startDate: String {
        guard let startTimestamp = event?.dates.first?.start else { return "" }
        let date = Date(timeIntervalSince1970: TimeInterval(startTimestamp))
        return date.formattedDate(format: "dd MMMM, yyyy")
    }
    
    var endDate: String {
        guard let endTimestamp = event?.dates.first?.end else { return "" }
        let date = Date(timeIntervalSince1970: TimeInterval(endTimestamp))
        return date.formattedDate(format: "E, MMM d • h:mm a")
    }
    
    var agentTitle: String {
        event?.participants?.first?.agent?.title ?? "No Name"
    }
    
    var role: String {
        event?.participants?.first?.role?.slug ?? "No Role"
    }
    
    var adress: String {
        event?.place?.address ?? "Unknown Address"
    }
    
    var location: String {
        event?.place?.location ?? "Unknown Location"
    }
    
    //    MARK: - Init
    init(eventID: Int, eventService: IEventAPIServiceForDetail) {
        self.eventID = eventID
        self.eventService = eventService
    }
    
    private func updateTexts() {
        self.descriptionText = event?.description?.htmlToString ?? "Нет описания"
        self.bodyText = event?.bodyText?.htmlToString ?? "Нет описания"
    }
    
    // Функция для получения деталей события
    func fetchEventDetails() async {
        do {
            let fetchedEvent = try await eventService.getEventDetails(eventID: eventID)
            DispatchQueue.main.async {
                self.event = fetchedEvent
            }
        } catch {
            print("Ошибка при получении события: \(error.localizedDescription)")
        }
    }
}
