//
//  EventAPIProtocols.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 22.11.2024.
//


/// Tuple alias combining all event-related protocols.
typealias IEventAPIService = IEventAPIServiceForExplore & IEventAPIServiceForDetail & IEventAPIServiceForSearch

/// Protocol for fetching event data related to exploration.
/// Includes methods for retrieving locations, categories, and events.
protocol IEventAPIServiceForExplore: IEventAPIServiceForSearch {
    /// Fetches a list of locations.
    /// - Parameter language: The language for location names.
    /// - Returns: An array of `EventLocation`.
    func getLocations(with language: Language?) async throws -> [EventLocation]
    
    /// Fetches a list of event categories.
    /// - Parameter language: The language for category names.
    /// - Returns: An array of `CategoryDTO`, or `nil` if no categories are found.
    func getCategories(with language: Language?) async throws -> [CategoryDTO]?
    
    /// Fetches a paginated list of events.
    /// - Parameters:
    ///   - location: The location filter.
    ///   - language: The language for event data.
    ///   - category: The event category filter.
    ///   - page: The page number for pagination.
    /// - Returns: An array of `EventDTO`.
    func getEvents(with category: String,_ location: String, _ language: Language, _ page: Int) async throws -> [EventDTO]
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
