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
    /// 
    func getCategories(with language: Language?) async throws -> [CategoryDTO] {
        let apiSpec: EventAPISpec = .getCategories(language: language)
        do {
            let categories = try await apiClient?.sendRequest(apiSpec)
            return categories as? [CategoryDTO] ?? []
        } catch {
            print(error)
            return []
        }
    }
    
    // MARK: - Events
    func getToDayEvents(location: String, language: Language?, page: Int?) async throws -> [ToDayEventDTO] {
        let apiSpec: EventAPISpec = .getTodayEvents(location: location, language: language, page: page)
        do {
            if let response = try await apiClient?.sendRequest(apiSpec) as? ToDayEventsDTO {
                return response.results
            }
        } catch {
            print(error)
        }
        return []
        
    }
    
    func getMovies(location: String, language: Language?, page: Int?) async throws -> [MovieDTO] {
        let apiSpec: EventAPISpec = .getMovies(location: location, language: language, page: page)
        do {
            if let response = try await apiClient?.sendRequest(apiSpec) as? MoviesResponseDTO {
                return response.results
            }
        } catch {
            print(error)
        }
        return []
    }
    
    func getLists(location: String, language: Language?, page: Int?) async throws -> [ListDTO] {
        let apiSpec: EventAPISpec = .getLists(location: location, language: language, page: page)
        do {
            if let response = try await apiClient?.sendRequest(apiSpec) as? ResponseListDTO {
                return response.results
            }
        } catch {
            print(error)
        }
        return []
    }
    

    /// Fetches a paginated list of events filtered by location, language, and category.
    func getUpcomingEvents(with category: String?, _ language: Language, _ page: Int?) async throws -> [EventDTO] {
        let apiSpec: EventAPISpec = .getUpcomingEventsWith(
            category: category,
            language: language,
            page: page ?? 1
        )
        do {
            if let response = try await apiClient?.sendRequest(apiSpec) as? APIResponseDTO {
                return response.results
            }
        } catch {
            print(error)
        }
        return []
    }
    
    func getNearbyYouEvents(with language: Language?, _ location: String, _ category: String?, _ page: Int?) async throws -> [EventDTO] {
        let apiSpec: EventAPISpec = .getNearbyYouEvents(language: language, location: location, category: category, page: page ?? 1)

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
    func getEventDetails(eventIDs: String, language: Language?) async throws -> [EventDTO] {
        let apiSpec = EventAPISpec.getEventDetails(eventIDs: eventIDs, language: language)
        do {
            if let response = try await apiClient?.sendRequest(apiSpec) as? APIResponseDTO {
                return response.results
            }
        } catch {
            print(error)
        }
        return []
    }
    
    func getUpcomingEvents(_ actualSince: String, _ actualUntil: String, _ language: Language, _ page: Int?) async throws -> [EventDTO] {
        let apiSpec: EventAPISpec = .getUpcominglEvents(
            actualSince: actualSince,
            actualUntil: actualUntil,
            language: language,
            page: page
        )

        do {
            if let response = try await apiClient?.sendRequest(apiSpec) as? APIResponseDTO {
                return response.results
            }
        } catch {
            print(error)
        }
        return []
    }
    
    func getPastEvents(_ actualUntil: String, _ language: Language, _ page: Int?) async throws -> [EventDTO] {
        let apiSpec: EventAPISpec = .getPastEvents(actualUntil: actualUntil, language: language, page: page)

        do {
            if let response = try await apiClient?.sendRequest(apiSpec) as? APIResponseDTO {
                return response.results
            }
        } catch {
            print(error)
        }
        return []
    }
    
    // MARK: - Search
    /// Searches for events using a text query.
    func getSearchedEvents(with searchText: String) async throws -> SearchResponseDTO? {
        let apiSpec: EventAPISpec = .getSerchedEventsWith(searchText: searchText)
        do {
            let events = try await apiClient?.sendRequest(apiSpec)
            return events as? SearchResponseDTO
        } catch {
            print(error)
            print(  "error in func" )
            return nil
        }
    }
    
    func getEventsWith(location: String, _ category: String?,_ language: Language) async throws -> [EventDTO] {
        let apiSpec: EventAPISpec = .getEventsForMap(coordinate: location, category: category, language: language)

        do {
            if let response = try await apiClient?.sendRequest(apiSpec) as? APIResponseDTO {
                return response.results
            }
        } catch {
            print(error)
        }
        return []
    }
}
