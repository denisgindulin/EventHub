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
                Text(eventsTest.first?.id.description ?? "" )
                Text(category.first?.name ?? "")
        }
    }
        .task {
            do {
                let apiSpec = EventAPISpec.getEventsWith(location: "msk", language: .ru, category: "theater", page: "2" )
                print("Generated Endpoint: \(apiSpec.endpoint)")
                
                let categories = try await apiManager.getCategories(with: Language.ru)
                category = categories ?? []
                let events = try await apiManager.getEvents(with: "msk", Language.ru, "theater", page: "2")
                eventsTest = events
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
