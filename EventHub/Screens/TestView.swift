//
//  TestView.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 20.11.2024.
//

import SwiftUI

struct TestView: View {
    @State private var eventsTest: [EventDTO] = []
    @State private var category: [EventCategory] = []
    @State private var locations: [EventLocation] = []
    
    let apiManager = EventAPIService()
    
    var body: some View {
        ZStack {
            Color.appBlue.ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                ToolBarView(
                    title: "Profile",
                    foregroundStyle: .white,
                    showBackButton: true,
                    actions: [
                        ToolBarAction(
                            icon: ToolBarButtonType.moreVertically.icon,
                            action: {},
                            hasBackground: false,
                            foregroundStyle: .black
                        ),
                        ToolBarAction(
                        icon: ToolBarButtonType.search.icon,
                        action: {},
                        hasBackground: false,
                        foregroundStyle: .black)
                    ]
                )
                .zIndex(1)
                Spacer()
                ScrollView {
//                    Text(eventsTest.map { $0.title ?? "" }.joined(separator: ", ") )
//                    Text(category.map { $0.name }.joined(separator: ", "))
                    Text(locations.map { $0.name ?? "" }.joined(separator: ", "))
                }
        }
    }
        .task {
            do {
                let apiSpec = EventAPISpec.getEventsWith(location: "new-york", language: .ru, category: "theater", page: "2" )
                print("Generated Endpoint: \(apiSpec.endpoint)")
                let apiSpecCat = EventAPISpec.getCategories(language: Language.ru)
                print("Generated Endpoint apiSpecCat: \(apiSpecCat.endpoint)")
                
                let apiSpecLoc = EventAPISpec.getLocation(language: Language.ru)
                print("Generated Endpoint apiSpecLoc: \(apiSpecLoc.endpoint)")
                
                let categories = try await apiManager.getCategories(with: Language.ru)
                category = categories ?? []
                let events = try await apiManager.getEvents(with: "msk", Language.ru, "theater", page: "2")
                eventsTest = events
                
                let locationsAPI = try await apiManager.getLocations(with: Language.eng)
                locations = locationsAPI
            } catch {
                let errorMessage = "Ошибка загрузки категорий: \(error.localizedDescription)"
                print(errorMessage)
            }
        }
 }
}

#Preview {
    TestView()
}
