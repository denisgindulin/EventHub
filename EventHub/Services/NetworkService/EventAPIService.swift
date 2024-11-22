//
//  EventAPIService.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 20.11.2024.
//

//
//  EventAPIService.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 20.11.2024.
//

import Foundation

/// Protocol defining the methods for fetching event data.
protocol IEventAPIService {
    func getLocations(with language: Language?) async throws -> [EventLocation]
    func getCategories(with language: Language?) async throws -> [EventCategory]?
    func getEvents(with location: String, _ language: Language, _ category: String, page: String) async throws -> [EventDTO]
    func getEventDetails(eventID: Int) async throws -> EventDTO?
    func getSearchedEvents(with searchText: String) async throws -> APIResponseDTO?
}

/// `EventAPIService` interacts with the KudaGo API to retrieve event data.
/// Includes fetching locations, categories, events, event details, and search results.
final class EventAPIService: APIService, IEventAPIService {
    
    // MARK: - Initializer
    /// Initializes the EventAPIService with an API client.
    init() {
        let apiClient = APIClient()
        super.init(apiClient: apiClient)
    }
    
    // MARK: - Locations
    /// Fetches a list of available locations.
    func getLocations(with language: Language?) async throws -> [EventLocation] {
        let apiSpec: EventAPISpec = .getLocation(language: language)
        do {
            let location = try await apiClient?.sendRequest(apiSpec)
            return location as? [EventLocation] ?? []
        } catch {
            print(error)
        }
        return []
    }
    
    // MARK: - Categories
    /// Fetches event categories based on the provided language.
    func getCategories(with language: Language?) async throws -> [EventCategory]? {
        let apiSpec: EventAPISpec = .getCategories(language: language)
        do {
            let categories = try await apiClient?.sendRequest(apiSpec)
            return categories as? [EventCategory]
        } catch {
            print(error)
            return nil
        }
    }
    
    // MARK: - Events
    /// Fetches a paginated list of events filtered by location, language, and category.
    func getEvents(with location: String, _ language: Language, _ category: String, page: String) async throws -> [EventDTO] {
        let apiSpec: EventAPISpec = .getEventsWith(location: location, language: language, category: category, page: page)
        do {
            if let response = try await apiClient?.sendRequest(apiSpec) as? APIResponseDTO {
                return response.results
            }
        } catch {
            print(error)
        }
        return []
    }
    
    // MARK: - Event Details
    /// Fetches detailed information about a specific event.
    func getEventDetails(eventID: Int) async throws -> EventDTO? {
        let apiSpec = EventAPISpec.getEventDetails(eventID: eventID)
        do {
            let eventDetails = try await apiClient?.sendRequest(apiSpec)
            return eventDetails as? EventDTO
        } catch {
            print(error)
            return nil
        }
    }
    
    // MARK: - Search
    /// Searches for events using a text query.
    func getSearchedEvents(with searchText: String) async throws -> APIResponseDTO? {
        let apiSpec: EventAPISpec = .getSerchedEventsWith(searchText: searchText)
        do {
            let events = try await apiClient?.sendRequest(apiSpec)
            return events as? APIResponseDTO
        } catch {
            print(error)
            return nil
        }
    }
}
