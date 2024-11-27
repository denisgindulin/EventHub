//
//  CoreDataManager.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 27.11.2024.
//

import CoreData
import SwiftUI

final class CoreDataManager: ObservableObject {
    let viewContext: NSManagedObjectContext
    
    @Published var events: [FavoriteEvent] = []
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createEvent(event: EventDTO) {
        let favoriteEvent = FavoriteEvent(context: viewContext)
        favoriteEvent.id = Int64(event.id)
        favoriteEvent.title = event.title
        favoriteEvent.descript = event.description
        favoriteEvent.bodyText = event.bodyText
        favoriteEvent.image = event.images.first?.image
        
        if let startTimestamp = event.dates.first?.start {
            favoriteEvent.start = Date(timeIntervalSince1970: TimeInterval(startTimestamp))
        }
        
        if let endTimestamp = event.dates.first?.end {
            favoriteEvent.end = Date(timeIntervalSince1970: TimeInterval(endTimestamp))
        }
        
        favoriteEvent.startDate = event.dates.first?.startDate
        favoriteEvent.endTime = event.dates.first?.endTime
        
        saveContext()
        fetchEvents()
    }
    
    func fetchEvents() {
        let request = FavoriteEvent.fetchRequest()
        let sortDescription = NSSortDescriptor(keyPath: \FavoriteEvent.id, ascending: true)
        request.sortDescriptors = [sortDescription]
        
        do {
            events = try viewContext.fetch(request)
        } catch {
            let nserror = error as NSError
            print("Не удалось получить события: \(nserror), \(nserror.userInfo)")
        }
    }
}
