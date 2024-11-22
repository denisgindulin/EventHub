//
//  EventDetailsViewModel.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 21.11.2024.
//

import Foundation

@MainActor
final class EventDetailsViewModel: ObservableObject {
    let eventService = EventAPIService()
    @Published var event: EventDTO?
    
    var title: String {
        event?.title ?? "No Title"
    }
    
    var description: String {
        event?.description ?? "No Description"
    }
    
    var place: String {
        event?.place?.title ?? "No place"
    }
    
    var startDate: String {
        var startDate = ""
        event?.dates?.forEach {
            startDate = $0.startDate ?? Date().formattedDate2()
        }
        return startDate
    }
    
    var participantRole: String {
        var role = ""
        event?.participants?.forEach {
            role = $0.role.name ?? "No Role"
        }
        return role
    }
    
    func fetchEventDetails() async {
        do {
            let fetchedEvent = try await eventService.getEventDetails(eventID: 173607)
            
            DispatchQueue.main.async {
                self.event = fetchedEvent
            }
            
        } catch {
            print("Ошибка при получении события: \(error.localizedDescription)")
        }
    }

    let imageUrl = URL(string: "https://images.unsplash.com/photo-1731921954767-8473de81c99e?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwzfHx8ZW58MHx8fHx8")
    let eventName = "International Band Music Concert"
    let date = Date.now
    let time = "Tuesday, 4:00PM - 9:00PM"
//    let place = "Gala Convention Center"
    let adress = "36 Guild Street London, UK"
    let person = "Ashfak Sayem"
    let personRole = "Organizer"
    let aboutEvent = "Все супер! Понравилось просто все: начиная со встречи и заканчивая прощанием. Встретил сам организатор. Все рассказал, пояснил что к чему. Понравилось, что за ходом игры наблюдают и не дают долго тупить. Даются подсказки, но легкие наводящие. Единственный минус это то, что в один момент нам слишком рано дали подсказку. В остальном просто супер. Реквизита минимум, действий максимум, качественный антураж. Ждем новых квестов от этих организаторов. Спасибо за настроение."
}
