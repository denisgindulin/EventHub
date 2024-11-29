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
        fetchEvents()
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
    
    func createEvent(event: ExploreEvent) {
        let favoriteEvent = FavoriteEvent(context: viewContext)
        favoriteEvent.id = event.id
        favoriteEvent.title = event.title
        favoriteEvent.date = event.date
        favoriteEvent.adress = event.adress
        favoriteEvent.image = event.image
        
        saveContext()
        fetchEvents()
    }
    
    func createEvent(event: EventDTO) {
        let favoriteEvent = FavoriteEvent(context: viewContext)
        favoriteEvent.id = event.id
        favoriteEvent.title = event.title
        favoriteEvent.date = Date(timeIntervalSince1970: TimeInterval(event.dates.first?.start ?? 1489312800))
        favoriteEvent.adress = event.place?.address
        favoriteEvent.image = event.images.first?.image
        
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
    
    func deleteEvent(event: FavoriteEvent) {
        viewContext.delete(event)
        saveContext()
        fetchEvents()
    }
    
    func deleteEvent(eventID: Int) {
        let fetchRequest: NSFetchRequest<FavoriteEvent> = FavoriteEvent.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", eventID)
        do {
            let favoriteEvents = try viewContext.fetch(fetchRequest)
            for event in favoriteEvents {
                viewContext.delete(event)
            }
            saveContext()
            fetchEvents()
        } catch {
            let nserror = error as NSError
            print("Ошибка при удалении события: \(nserror), \(nserror.userInfo)")
        }
    }
}
