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
    @NSManaged public var title: String?
    @NSManaged public var image: String?
    @NSManaged public var bodyText: String?
    @NSManaged public var descript: String?
    @NSManaged public var startDate: String?
    @NSManaged public var start: Date?
    @NSManaged public var end: Date?
    @NSManaged public var endTime: String?

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
