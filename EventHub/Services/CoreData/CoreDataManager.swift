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
    
    func deleteEvent(event: ExploreEvent) {
        let fetchRequest: NSFetchRequest<FavoriteEvent> = FavoriteEvent.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", event.id)
        do {
            let favoriteEvents = try viewContext.fetch(fetchRequest)
            if let favoriteEvent = favoriteEvents.first {
                viewContext.delete(favoriteEvent)
                saveContext()
                fetchEvents()
            }
        } catch {
            let nserror = error as NSError
            print("Не удалось удалить событие: \(nserror), \(nserror.userInfo)")
        }
    }
}
