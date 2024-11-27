//
//  FavoriteEvent+CoreDataClass.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 27.11.2024.
//
//

import Foundation
import CoreData

@objc(FavoriteEvent)
public class FavoriteEvent: NSManagedObject {

}

extension FavoriteEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteEvent> {
        return NSFetchRequest<FavoriteEvent>(entityName: "FavoriteEvent")
    }

    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var adress: String?

}

extension FavoriteEvent : Identifiable {
    func deleteEvent() {
        managedObjectContext?.delete(self)
        
        do {
            try managedObjectContext?.save()
        } catch {
            print("Deleting error: \(error.localizedDescription)")
        }
    }
}
