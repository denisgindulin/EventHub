//
//  APIService.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 20.11.2024.
//

import Foundation

class APIService {
    private(set) var apiClient: APIClient?
    
    init(apiClient: APIClient?) {
        self.apiClient = apiClient
    }
}
