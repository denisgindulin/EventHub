//
//  EventAPISpec.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 20.11.2024.
//

import Foundation
/*
spb - Санкт-Петербург
msk - Москва
nsk - Новосибирск
ekb - Екатеринбург
nnv - Нижний Новгород
kzn - Казань
vbg - Выборг
smr - Самара
krd - Краснодар
sochi - Сочи
ufa - Уфа
krasnoyarsk - Красноярск
kev - Киев
new-york - Нью-Йорк
*/
// MARK: - NewsAPISpec Enum
enum EventAPISpec: APISpec {
    
    case getCategories(language: Language?)
    case getEventsWith(location: String, language: Language?, category: String, page: String)
    case getEventDetails(eventID: Int, language: Language?)
    case getSerchedEventsWith(searchText: String)
    
    // MARK: - Base URL Path
    private var path: String {
        switch self {
        case .getCategories:
            return  "public-api/v1.4/place-categories"
        case .getEventsWith:
            return "public-api/v1.4/events/"
        case .getEventDetails(eventID: let eventID):
            return "public-api/v1.4/events/\(eventID)"
        case .getSerchedEventsWith:
            return "public-api/v1.4/search"
        }
    }
    
    // MARK: - Query Items
    private var queryItems: [URLQueryItem] {
        switch self {
        case .getCategories(language: let language):
            if let language = language {
                return [URLQueryItem(name: "lang", value: language.rawValue)]
            } else {
                return []
            }

        case .getEventsWith(location: let location, language: let language, category: let category, let page):
            var items: [URLQueryItem] = [
                URLQueryItem(name: "expand", value: "place,\(location),dates,participants"),
                URLQueryItem(name: "fields", value: "id,place,location,dates,participants"),
                URLQueryItem(name: "categories", value: category)
            ]
            
            if let language = language {
                items.append(URLQueryItem(name: "lang", value: language.rawValue))
            }
            items.append(URLQueryItem(name: "page", value: page))
            return items
            
        case .getEventDetails(eventID: _, language: let language):
            if let language = language {
                        return [URLQueryItem(name: "lang", value: language.rawValue)]
                    } else {
                        return []
                    }
            
        case .getSerchedEventsWith(searchText: let searchText):
            return [
                URLQueryItem(name: "q", value: searchText)
            ]
        }
    }
  
    // MARK: - Endpoint
    var endpoint: String {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "kudago.com"
        components.path = "/" + path
        components.queryItems = queryItems
        return components.url?.absoluteString ?? ""
    }
    
    // MARK: - HTTP Method
    var method: HttpMethod {
        return .get
    }
    
    // MARK: - Return Type
    var returnType: DecodableType.Type {
        switch self {
            
        case .getCategories:
            return [EventCategory].self
        case .getEventsWith:
            return APIResponseDTO.self
        case .getEventDetails:
            return APIResponseDTO.self
        case .getSerchedEventsWith:
            return APIResponseDTO.self
        }
    }
    
    // MARK: - Request Body
    var body: Data? {
        return nil
    }
}
