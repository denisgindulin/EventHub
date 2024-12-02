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
    private let eventService: IAPIServiceForDetail
    private let language = Language.ru
    
    @Published var event: DetailEventModel? {
        didSet {
            self.updateTexts()
        }
    }
    
    @Published var bodyText: String = "Нет описания"
    @Published var descriptionText: String = "Нет описания"
    
    // Вычисляемые свойства для удобства использования во View
    var image: String? {
        return event?.image
    }
    
    var title: String {
        event?.title.capitalized ?? "Нет заголовка"
    }
    
    var startDate: String {
      
        let date = event?.startDate ?? Date()
        return date.formattedDate(format: "dd MMMM, yyyy")
    }
    
    var endDate: String {
        let date = event?.endDate ?? Date()
        return date.formattedDate(format: "E, MMM d • h:mm a")
    }
    
    var agentTitle: String {
        event?.participants.first?.agent?.title ?? "No Name"
    }
    
    var role: String {
        event?.participants.first?.role?.slug ?? "No Role"
    }
    
    var adress: String {
        event?.adress ?? "Unknown Address"
    }
    
    var location: String {
        event?.location ?? "Unknown Location"
    }
    
    //    MARK: - Init
    init(eventID: Int, eventService: IAPIServiceForDetail = DIContainer.resolve(forKey: .networkService) ?? EventAPIService()) {
        self.eventID = eventID
        self.eventService = eventService
    }
    
    private func updateTexts() {
        self.descriptionText = event?.description.htmlToString ?? "Нет описания"
        self.bodyText = event?.bodyText.htmlToString ?? "Нет описания"
    }
    
    // Функция для получения деталей события
    func fetchEventDetails() async {
        let eventIDString: String = String(self.eventID)
        do {
            let fetchedEvent = try await eventService.getEventDetails(eventIDs: eventIDString, language: language)
            self.event = fetchedEvent.first.map { DetailEventModel( dto: $0 )}
        } catch {
            print("Ошибка при получении события: \(error.localizedDescription)")
        }
    }
}
