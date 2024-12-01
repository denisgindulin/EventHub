//
//  SearchViewModel.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 01.12.2024.
//

import Foundation

enum SearchScreenType {
    case withData
    case withoutData
}

@MainActor
final class SearchViewModel: ObservableObject {
    
    private let apiService: IAPIServiceForSearch
    
    private let searchScreenType: SearchScreenType
    private var localData: [ExploreModel] = []
    private var currentSearchTask: Task<Void, Never>?
    
    @Published var error: Error? = nil
    @Published var searchResults: [ExploreModel] = []
    @Published var searchText: String = "" {
        didSet {
            debounceSearchTask()
        }
    }
    
    // MARK: - Init
    init(
        searchScreenType: SearchScreenType,
        localData: [ExploreModel] = [],
        apiService: IAPIServiceForSearch = DIContainer.resolve(forKey: .networkService) ?? EventAPIService()
    ) {
        self.searchScreenType = searchScreenType
        self.localData = localData
        self.apiService = apiService
    }
    
    // MARK: - Вebounce Search Task
        private func debounceSearchTask() {
            currentSearchTask?.cancel()
            
            currentSearchTask = Task {
                try? await Task.sleep(nanoseconds: 300_000_000)
                
                guard !Task.isCancelled else { return }
                await performSearch()
            }
        }
    // MARK: - Filter Events
    func filterEvents(orderType: DisplayOrderType) {
        switch orderType {
        case .alphabetical:
            searchResults = searchResults.sorted(by: { $0.title < $1.title })
        case .date:
            searchResults = searchResults.sorted(by: { $0.date < $1.date })
        }
    }
    
    // MARK: - Perform Search
       private func performSearch() async {
           switch searchScreenType {
           case .withData:
               filterLocalData()
           case .withoutData:
               await fetchSearchedEvents()
           }
       }
    
    // MARK: - Filter Local Data
    private func filterLocalData() {
        searchResults = localData.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    // MARK: - Network API Methods
    func fetchSearchedEvents() async {
        do {
            let searchEventsDTO = try await apiService.getSearchedEvents(with: searchText)
            let apiSpecLoc = EventAPISpec.getSerchedEventsWith(searchText: searchText)
                         print("Generated Endpoint Searched: \(apiSpecLoc.endpoint)")
            searchResults = searchEventsDTO?.results.map { ExploreModel(searchDTO: $0) } ?? []
        } catch {
            print(" No searched func result")
            self.error = error
        }
    }
}
