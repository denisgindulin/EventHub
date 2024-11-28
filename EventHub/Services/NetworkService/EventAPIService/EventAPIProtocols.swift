//
//  EventAPIProtocols.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 22.11.2024.
//

import Foundation


/// Tuple alias combining all event-related protocols.
typealias IEventAPIService = IAPIServiceForExplore & IEventAPIServiceForDetail & IEventAPIServiceForSearch & IEventAPIServiceForEvents

/// Protocol for fetching event data related to exploration.
/// Includes methods for retrieving locations, categories, and events.
protocol IAPIServiceForExplore: IEventAPIServiceForSearch {
    /// Fetches a list of locations.
    /// - Parameter language: The language for location names.
    /// - Returns: An array of `EventLocation`.
    func getLocations(with language: Language?) async throws -> [EventLocation]
    
    /// Fetches a list of event categories.
    /// - Parameter language: The language for category names.
    /// - Returns: An array of `CategoryDTO`, or `nil` if no categories are found.
    func getCategories(with language: Language?) async throws -> [CategoryDTO]?
    
    /// Fetches a paginated list of Upcoming events.
    /// - Parameters:
    ///   - language: The language for event data.
    ///   - category: The event category filter.
    ///   - page: The page number for pagination.
    /// - Returns: An array of `EventDTO`.
    func getUpcomingEvents(with category: String?,_ language: Language, _ page: Int?) async throws -> [EventDTO]
    
    /// Fetches a paginated list of Nearby You  events.
    /// - Parameters:
    ///   - language: The language for event data.
    ///   - location: The event location filter.
    ///   - page: The page number for pagination.
    /// - Returns: An array of `EventDTO`.
    func getNearbyYouEvents(with language: Language?,_ location: String,_ page: Int?) async throws -> [EventDTO]
}

/// Protocol for fetching detailed event information.
protocol IEventAPIServiceForDetail {
    /// Fetches details of a specific event.
    /// - Parameters:
    ///   - eventID: The ID of the event.
    ///   - language: The language for event details.
    /// - Returns: An optional `EventDTO` with event details.
    func getEventDetails(eventID: Int) async throws -> EventDTO?
}

/// Protocol for searching events.
protocol IEventAPIServiceForSearch {
    /// Fetches events matching the search text.
    /// - Parameter searchText: The text to search for.
    /// - Returns: An optional `APIResponseDTO` containing the search results.
    func getSearchedEvents(with searchText: String) async throws -> APIResponseDTO?
}

protocol IEventAPIServiceForEvents {
    func getUpcomingEvents(_ actualSince: String,_ actualUntil: String,_ language: Language, _ page: Int?) async throws -> [EventDTO]
    func getPastEventsEvents(_ actualUntil: String,_ language: Language, _ page: Int?) async throws -> [EventDTO]
}
