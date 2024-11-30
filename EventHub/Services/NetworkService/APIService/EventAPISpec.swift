//
//  EventAPISpec.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 20.11.2024.
//

import Foundation

// MARK: - EventAPISpec
/// Defines the API endpoints and configurations for interacting with the KudaGo Event API.
enum EventAPISpec: APISpec {
    case getLocation(language: Language?)
    case getCategories(language: Language?)
    case getUpcomingEventsWith(
        category: String?,
        language: Language?,
        page: Int?
    )
    case getNearbyYouEvents(language: Language?, location: String, catetory: String?, page: Int?)
    case getUpcominglEvents(actualSince: String, actualUntil: String, language: Language?, page: Int?)
    case getPastEvents(actualUntil: String,language: Language?, page: Int?)
    case getEventDetails(eventID: Int)
    case getSerchedEventsWith(searchText: String)
    
    // MARK: - Base URL Path
    /// Returns the base path for each endpoint.
    private var path: String {
        switch self {
        case .getLocation:
            return "public-api/v1.4/locations"
        case .getCategories:
            return "public-api/v1.4/event-categories"
        case .getUpcomingEventsWith:
            return "public-api/v1.4/events/"
        case .getNearbyYouEvents:
            return "public-api/v1.4/events/"
        case .getUpcominglEvents:
            return "public-api/v1.4/events/"
        case .getPastEvents:
            return "public-api/v1.4/events/"
        case .getEventDetails(eventID: let eventID):
            return "public-api/v1.4/events/\(eventID)"
        case .getSerchedEventsWith:
            return "public-api/v1.4/search/"
        }
    }
    
    // MARK: - Query Items
    /// Returns query parameters for the specified API call.
    private var queryItems: [URLQueryItem] {
        switch self {
        case .getLocation(let language):
            return language.map { [URLQueryItem(name: "lang", value: $0.rawValue)] } ?? []
            
        case .getCategories(let language):
            return language.map { [URLQueryItem(name: "lang", value: $0.rawValue)] } ?? []
            
        case .getUpcomingEventsWith(let category, let language, let page):
            let currentDate = Date()
            let unixTimestamp = Int(currentDate.timeIntervalSince1970)
            
            var items: [URLQueryItem] = [
                URLQueryItem(name: "actual_since", value: String(unixTimestamp)),
                URLQueryItem(name: "order_by", value: "publication_date"),
                URLQueryItem(name: "expand", value: "location,place,dates,participants"),
                URLQueryItem(name: "fields", value: "id,title,description,body_text,favorites_count,place,location,dates,participants,images,site_url")
            ]
            
            if let category = category {
                items.append(URLQueryItem(name: "categories", value: category))
            }
            
            if let language = language {
                items.append(URLQueryItem(name: "lang", value: language.rawValue))
            }
            if let page = page {
                items.append(URLQueryItem(name: "page", value: String(page)))
            }
            return items
            
        case .getNearbyYouEvents(let language, let location, let category, let page):
            let currentDate = Date()
            let unixTimestamp = Int(currentDate.timeIntervalSince1970)
            
            var items: [URLQueryItem] = [
                URLQueryItem(name: "actual_since", value: String(unixTimestamp)),
                URLQueryItem(name: "location", value: location),
                URLQueryItem(name: "order_by", value: "publication_date"),
                URLQueryItem(name: "expand", value: "location,place,dates,participants"),
                URLQueryItem(name: "fields", value: "id,title,description,body_text,favorites_count,place,location,dates,participants,images,site_url")
            ]
            
            
            if let language = language {
                items.append(URLQueryItem(name: "lang", value: language.rawValue))
            }
            
            if let category = category {
                items.append(URLQueryItem(name: "categories", value: category))
            }
            
            if let page = page {
                items.append(URLQueryItem(name: "page", value: String(page)))
            }
            
            return items
            
        case .getUpcominglEvents(actualSince: let actualSince, actualUntil: let actualUntil, language: let language, page: let page):
            var items: [URLQueryItem] = [
                URLQueryItem(name: "actual_since", value: actualSince),
                URLQueryItem(name: "actual_until", value: actualUntil),
                URLQueryItem(name: "expand", value: "location,place,dates,participants"),
                URLQueryItem(name: "fields", value: "id,title,body_text,place,location,dates,images")
            ]
            
            if let language = language {
                items.append(URLQueryItem(name: "lang", value: language.rawValue))
            }
            
            if let page = page {
                items.append(URLQueryItem(name: "page", value: String(page)))
            }
            
            return items
            
        case .getPastEvents(actualUntil: let actualUntil, language: let language, page: let page):
            var items: [URLQueryItem] = [
                URLQueryItem(name: "actual_until", value: actualUntil),
                URLQueryItem(name: "expand", value: "location,place,dates,participants"),
                URLQueryItem(name: "fields", value: "id,title,body_text,place,location,dates,images")
            ]
            
            if let language = language {
                items.append(URLQueryItem(name: "lang", value: language.rawValue))
            }
            
            if let page = page {
                items.append(URLQueryItem(name: "page", value: String(page)))
            }
            
            return items
            
        case .getEventDetails:
            let items: [URLQueryItem] = [
                URLQueryItem(name: "expand", value: "location,place,dates,participants"),
                URLQueryItem(name: "fields", value: "id,title,description,body_text,favorites_count,place,location,dates,participants,categories,images")
            ]
            return items
            
        case .getSerchedEventsWith(searchText: let searchText):
            let items: [URLQueryItem] = [
                URLQueryItem(name: "ctype", value: "event"),
                URLQueryItem(name: "expand", value: "location,place,dates,participants,images"),
                URLQueryItem(name: "fields", value: "id,title,body_text,place,location,dates,images"),
                URLQueryItem(name: "q", value: searchText)
            ]
            return items
        }
    }
  
    // MARK: - Endpoint
    /// Constructs the full endpoint URL.
    var endpoint: String {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "kudago.com"
        components.path = "/" + path
        components.queryItems = queryItems
        return components.url?.absoluteString ?? ""
    }
    
    // MARK: - HTTP Method
    /// Returns the HTTP method for the request.
    var method: HttpMethod {
        return .get
    }
    
    // MARK: - Return Type
    /// Specifies the expected return type of the API response.
    var returnType: DecodableType.Type {
        switch self {
        case .getLocation:
            return [EventLocation].self
        case .getCategories:
            return [CategoryDTO].self
        case .getUpcomingEventsWith:
            return APIResponseDTO.self
        case .getNearbyYouEvents:
            return APIResponseDTO.self
        case .getUpcominglEvents:
            return APIResponseDTO.self
        case .getPastEvents:
            return APIResponseDTO.self
        case .getEventDetails:
            return EventDTO.self
        case .getSerchedEventsWith:
            return EventSearchResponse.self
        }
    }
    
    // MARK: - Request Body
    /// Returns the HTTP body for the request (always `nil` in this case).
    var body: Data? {
        return nil
    }
}
