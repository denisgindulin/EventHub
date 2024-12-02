//
//  EventAPIProtocols.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 22.11.2024.
//

import Foundation

/// Tuple alias combining all event-related protocols.
typealias IEventAPIService = IAPIServiceForExplore & IAPIServiceForDetail & IAPIServiceForSearch & IAPIServiceForEvents & IAPIServiceForMap

/// Protocol for fetching event data related to exploration.
/// Includes methods for retrieving locations, categories, and events.
protocol IAPIServiceForExplore: IAPIServiceForDetail {
    /// Fetches a list of locations.
    /// - Parameter language: The language for location names.
    /// - Returns: An array of `EventLocation`.
    func getLocations(with language: Language?) async throws -> [EventLocation]
    
    /// Fetches a list of event categories.
    /// - Parameter language: The language for category names.
    /// - Returns: An array of `CategoryDTO`, or `nil` if no categories are found.
    func getCategories(with language: Language?) async throws -> [CategoryDTO]
    
    /// Fetches a paginated list of today's events.
    /// - Parameters:
    ///   - location: The location to filter events.
    ///   - language: The language for event data.
    ///   - page: The page number for pagination (optional).
    /// - Returns: An array of `ToDayEventDTO`.
    func getToDayEvents(location: String, language: Language?, page: Int?) async throws -> [ToDayEventDTO]
    
    func getMovies(location: String, language: Language?, page: Int?) async throws -> [MovieDTO]
    
    func getLists(location: String, language: Language?, page: Int?) async throws -> [ListDTO]
    
    /// Fetches a paginated list of upcoming events.
    /// - Parameters:
    ///   - category: The event category filter (optional).
    ///   - language: The language for event data.
    ///   - page: The page number for pagination (optional).
    /// - Returns: An array of `EventDTO`.
    func getUpcomingEvents(with category: String?, _ language: Language, _ page: Int?) async throws -> [EventDTO]
    
    /// Fetches a paginated list of nearby events.
    /// - Parameters:
    ///   - location: The location to filter events.
    ///   - category: The event category filter (optional).
    ///   - language: The language for event data.
    ///   - page: The page number for pagination (optional).
    /// - Returns: An array of `EventDTO`.
    func getNearbyYouEvents(with language: Language?, _ location: String, _ category: String?, _ page: Int?) async throws -> [EventDTO]
}

/// Protocol for fetching detailed event information.
protocol IAPIServiceForDetail {
    /// Fetches details of a specific event by its ID.
    /// - Parameters:
    ///   - eventID: The ID of the event.
    ///   - language: The language for event details (optional).
    /// - Returns: An optional `EventDTO` with event details.
    func getEventDetails(eventIDs: String, language: Language?) async throws -> [EventDTO]
}

/// Protocol for searching events.
protocol IAPIServiceForSearch {
    /// Fetches events matching the specified search text.
    /// - Parameter searchText: The text to search for events.
    /// - Returns: An optional `SearchResponseDTO` containing the search results.
    func getSearchedEvents(with searchText: String) async throws -> SearchResponseDTO?
}

/// Protocol for fetching upcoming and past events within a date range.
protocol IAPIServiceForEvents {
    /// Fetches upcoming events within the specified date range.
    /// - Parameters:
    ///   - actualSince: Start date in string format.
    ///   - actualUntil: End date in string format.
    ///   - language: The language for event data.
    ///   - page: The page number for pagination (optional).
    /// - Returns: An array of `EventDTO`.
    func getUpcomingEvents(_ actualSince: String, _ actualUntil: String, _ language: Language, _ page: Int?) async throws -> [EventDTO]
    
    /// Fetches past events up to the specified end date.
    /// - Parameters:
    ///   - actualUntil: End date in string format.
    ///   - language: The language for event data.
    ///   - page: The page number for pagination (optional).
    /// - Returns: An array of `EventDTO`.
    func getPastEvents(_ actualUntil: String, _ language: Language, _ page: Int?) async throws -> [EventDTO]
}

/// Protocol for map-related services including searching and fetching categories and events by location.
protocol IAPIServiceForMap: IAPIServiceForSearch {
    
    /// Fetches a list of event categories available on the map.
    /// - Parameter language: The language for category names (optional).
    /// - Returns: An array of `CategoryDTO`.
    func getCategories(with language: Language?) async throws -> [CategoryDTO]
    
    /// Fetches events based on the specified location and category filters.
    /// - Parameters:
    ///   - location: The location to filter events by.
    ///   - category: The event category filter (optional).
    ///   - language: The language for event data.
    /// - Returns: An array of `EventDTO`.
    func getEventsWith(location: String, _ category: String?, _ language: Language) async throws -> [EventDTO]
}
