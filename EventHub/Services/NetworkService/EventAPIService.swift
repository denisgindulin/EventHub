//
//  EventAPIService.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 20.11.2024.
//

import Foundation

protocol IEventAPIService {
    func getLocations(with language: Language?) async throws -> [EventLocation]
    func getCategories(with language: Language?) async throws -> [EventCategory]?
    func getEvents(with location: String,_ language: Language,_ category: String, page: String) async throws -> [EventDTO]
    func getEventDetails(eventID: Int, language: Language) async throws -> EventDTO? 
    func getSearchedEvents(with searchText: String) async throws -> APIResponseDTO?
}

// https://kudago.com/public-api/v1.2/events/?expand=place,location,dates,participants&fields=id,place,location,dates,participants
// https://kudago.com/public-api/v1.4/events?categories=theater&page=2&lang=ru&expand=msk,dates,images,participants
final class EventAPIService: APIService, IEventAPIService {

    
    
    // MARK: - Initializer
    init() {
        let apiClient = APIClient()
        super.init(apiClient: apiClient)
    }
    
    
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
    
    func getEvents(with location: String,_ language: Language,_ category: String, page: String) async throws -> [EventDTO] {
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
    
    func getEventDetails(eventID: Int, language: Language) async throws -> EventDTO? {
        let apiSpec = EventAPISpec.getEventDetails(eventID: eventID, language: language)
        do {
            let eventDetails = try await apiClient?.sendRequest(apiSpec)
            return eventDetails as? EventDTO
        } catch {
            print(error)
            return nil
        }
    }
    
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
