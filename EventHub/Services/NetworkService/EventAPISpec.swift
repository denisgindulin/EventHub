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
    case getEventsWith(location: String, language: Language?, category: String, page: String)
    case getEventDetails(eventID: Int, language: Language?)
    case getSerchedEventsWith(searchText: String)
    
    // MARK: - Base URL Path
    /// Returns the base path for each endpoint.
    private var path: String {
        switch self {
        case .getLocation:
            return "public-api/v1.4/locations"
        case .getCategories:
            return "public-api/v1.4/event-categories"
        case .getEventsWith:
            return "public-api/v1.4/events/"
        case .getEventDetails(eventID: let eventID):
            return "public-api/v1.4/events/\(eventID)"
        case .getSerchedEventsWith:
            return "public-api/v1.4/search"
        }
    }
    
    // MARK: - Query Items
    /// Returns query parameters for the specified API call.
    private var queryItems: [URLQueryItem] {
        switch self {
        case .getLocation(language: let language):
            return language.map { [URLQueryItem(name: "lang", value: $0.rawValue)] } ?? []
            
        case .getCategories(language: let language):
            return language.map { [URLQueryItem(name: "lang", value: $0.rawValue)] } ?? []
            
        case .getEventsWith(location: let location, language: let language, category: let category, let page):
            var items: [URLQueryItem] = [
                URLQueryItem(name: "expand", value: "place,\(location),dates,participants"),
                URLQueryItem(name: "fields", value: "id,title,description,body_text,favorites_count,place,location,dates,participants"),
                URLQueryItem(name: "categories", value: category)
            ]
            if let language = language {
                items.append(URLQueryItem(name: "lang", value: language.rawValue))
            }
            items.append(URLQueryItem(name: "page", value: page))
            return items
            
        case .getEventDetails(eventID: _, language: let language):
            return language.map { [URLQueryItem(name: "lang", value: $0.rawValue)] } ?? []
            
        case .getSerchedEventsWith(searchText: let searchText):
            return [URLQueryItem(name: "q", value: searchText)]
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
        case .getEventsWith:
            return APIResponseDTO.self
        case .getEventDetails:
            return APIResponseDTO.self
        case .getSerchedEventsWith:
            return APIResponseDTO.self
        }
    }
    
    // MARK: - Request Body
    /// Returns the HTTP body for the request (always `nil` in this case).
    var body: Data? {
        return nil
    }
}
