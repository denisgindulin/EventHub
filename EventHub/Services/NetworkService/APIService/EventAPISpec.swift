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
    case getTodayEvents(location: String, language: Language?, page: Int?)
    case getMovies(location: String, language: Language?, page: Int?)
    case getLists(location: String, language: Language?, page: Int?)
    case getNearbyYouEvents(language: Language?, location: String, category: String?, page: Int?)
    case getUpcominglEvents(actualSince: String, actualUntil: String, language: Language?, page: Int?)
    case getPastEvents(actualUntil: String, language: Language?, page: Int?)
    case getEventDetails(eventIDs: String, language: Language?)
    case getSerchedEventsWith(searchText: String)
    case getEventsForMap(coordinate: String, category: String?, language: Language?)
    
    // MARK: - Base URL Path
    /// Returns the base path for each endpoint.
    private var path: String {
        switch self {
        case .getLocation:
            return "public-api/v1.4/locations"
        case .getCategories:
            return "public-api/v1.4/event-categories"
            
        case .getTodayEvents:
            return "/public-api/v1.4/events-of-the-day"
        case .getMovies:
            return "/public-api/v1.4/movies/"
        case .getLists:
            return "/public-api/v1.4/lists/"
            
        case .getUpcomingEventsWith:
            return "public-api/v1.4/events"
        case .getNearbyYouEvents:
            return "public-api/v1.4/events"
            
        case .getUpcominglEvents:
            return "public-api/v1.4/events"
        case .getPastEvents:
            return "public-api/v1.4/events"
            
        case .getEventDetails:
            return "public-api/v1.4/events/"
            
        case .getSerchedEventsWith:
            return "public-api/v1.4/search"
            
        case .getEventsForMap:
            return "public-api/v1.4/events"
       
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
            
        case .getTodayEvents(let location, let language, let page):
            
            var items: [URLQueryItem] = [
                URLQueryItem(name: "location", value: location)
            ]
            
            if let language = language {
                items.append(URLQueryItem(name: "lang", value: language.rawValue))
            }
            if let page = page {
                items.append(URLQueryItem(name: "page", value: String(page)))
            }
            return items
            
        case .getMovies(location: let location, language: let language, page: let page):
            
            let currentDate = Date.now.ISO8601Format()
            
            var items: [URLQueryItem] = [
                URLQueryItem(name: "location", value: location),
                URLQueryItem(name: "page_size", value: "30"),
                URLQueryItem(name: "actual_since", value: currentDate),
                URLQueryItem(name: "order_by", value: "-publication_date"),
                URLQueryItem(name: "expand", value: "poster"),
                URLQueryItem(name: "fields", value: "id,title,year,poster,site_url")
            ]
            
            if let language = language {
                items.append(URLQueryItem(name: "lang", value: language.rawValue))
            }
            
            if let page = page {
                items.append(URLQueryItem(name: "page", value: String(page)))
            }
            return items
            
        case .getLists(location: let location, language: let language, page: let page):
            let currentDate = Date.now.ISO8601Format()
            var items: [URLQueryItem] = [
                URLQueryItem(name: "location", value: location),
                URLQueryItem(name: "page_size", value: "30"),
                URLQueryItem(name: "actual_since", value: currentDate),
                URLQueryItem(name: "order_by", value: "-publication_date"),
                URLQueryItem(name: "fields", value: "id,slug,title,publication_date,site_url")
            ]
            
            if let language = language {
                items.append(URLQueryItem(name: "lang", value: language.rawValue))
            }
            if let page = page {
                items.append(URLQueryItem(name: "page", value: String(page)))
            }
            return items
            
        case .getUpcomingEventsWith(let category, let language, let page):
            let currentDate = Date.now.ISO8601Format()
            
            var items: [URLQueryItem] = [
                URLQueryItem(name: "page_size", value: "30"),
                URLQueryItem(name: "actual_since", value: currentDate),
                URLQueryItem(name: "order_by", value: "-publication_date"),
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
            let currentDate = Date.now.ISO8601Format()
            
            var items: [URLQueryItem] = [
                URLQueryItem(name: "page_size", value: "30"),
                URLQueryItem(name: "actual_since", value: currentDate),
                URLQueryItem(name: "location", value: location),
                URLQueryItem(name: "order_by", value: "-publication_date"),
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
                URLQueryItem(name: "page_size", value: "20"),
                URLQueryItem(name: "order_by", value: "-publication_date"),
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
                URLQueryItem(name: "page_size", value: "20"),
                URLQueryItem(name: "order_by", value: "-publication_date"),
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
            
        case .getEventDetails(eventIDs: let eventIDs, language: let language):
            var items: [URLQueryItem] = [
                URLQueryItem(name: "ids", value: eventIDs),
                URLQueryItem(name: "expand", value: "location,place,dates,participants"),
                URLQueryItem(name: "fields", value: "id,title,description,body_text,favorites_count,place,location,dates,participants,categories,images")
            ]
            if let language = language {
                items.append(URLQueryItem(name: "lang", value: language.rawValue))
            }
            return items
            
        case .getSerchedEventsWith(let searchText):
            let currentDate = Date.now.ISO8601Format()
            
            return [
                URLQueryItem(name: "q", value: searchText),
                URLQueryItem(name: "page_size", value: "50"),
                URLQueryItem(name: "actual_since", value: currentDate),
                URLQueryItem(name: "expand", value: "location,place,dates"),
                URLQueryItem(name: "fields", value: "id,title,description,place,location,dates,images"),
                URLQueryItem(name: "order_by", value: "-publication_date")
            ]

        case .getEventsForMap(let coordinate, let category, let language):
            let currentDate = Date.now.ISO8601Format()
            var items: [URLQueryItem] = [
                URLQueryItem(name: "location", value: coordinate),
                URLQueryItem(name: "page_size", value: "50"),
                URLQueryItem(name: "page_size", value: "50"),
                URLQueryItem(name: "order_by", value: "-dates"),
                URLQueryItem(name: "actual_since", value: currentDate),
                URLQueryItem(name: "expand", value: "location,place,dates"),
                URLQueryItem(name: "fields", value: "id,title,place,location,dates,images")
            ]
            
            if let category = category {
                items.append(URLQueryItem(name: "categories", value: category))
            }
            
            if let language = language {
                items.append(URLQueryItem(name: "lang", value: language.rawValue))
            }
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
            return APIResponseDTO.self
        case .getSerchedEventsWith:
            return SearchResponseDTO.self
        case .getEventsForMap:
            return APIResponseDTO.self
        case .getTodayEvents:
            return ToDayEventsDTO.self
        case .getMovies:
            return MoviesResponseDTO.self
        case .getLists:
            return ResponseListDTO.self
        }
    }
    
    // MARK: - Request Body
    /// Returns the HTTP body for the request (always `nil` in this case).
    var body: Data? {
        return nil
    }
}
