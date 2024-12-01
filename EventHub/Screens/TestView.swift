////
////  TestView.swift
////  EventHub
////
////  Created by Келлер Дмитрий on 20.11.2024.
////
//
//import SwiftUI
//
//struct TestView: View {
//    @State private var eventsTest: [EventDTO] = []
//    @State private var category: [CategoryDTO] = []
//    @State private var locations: [EventLocation] = []
//    @State var detail: EventDTO? = nil
//    let apiManager = EventAPIService()
//    
//    var body: some View {
//        ZStack {
//            Color.white.ignoresSafeArea(.all)
//            
//            VStack(spacing: 0) {
//                ToolBarView(
//                    title: "Profile",
//                    showBackButton: true,
//                    actions: [
//
//                        ToolBarAction(
//                        icon: ToolBarButtonType.search.icon,
//                        action: {},
//                        hasBackground: false,
//                        foregroundStyle: .black)
//                    ]
//                )
//                .zIndex(1)
//                Spacer()
//                ScrollView {
////                    Text(eventsTest.map { $0.title ?? "" }.joined(separator: ", ") )
////                    Text(category.map { $0.name }.joined(separator: ", "))
////                    Text(locations.map { $0.name ?? "" }.joined(separator: ", "))
//                    Text(detail?.title ?? "")
//                }
//        }
//    }
//        .task {
//            do {
//                let apiSpecDet = EventAPISpec.getEventDetails(eventID: 173607)
//                print("Detail Endpoint: \(apiSpecDet.endpoint)")
//                
////                let apiSpec = EventAPISpec.getEventsWith(location: "new-york", language: .ru, category: "theater", page: "2" )
////                print("Generated Endpoint: \(apiSpec.endpoint)")
////                let apiSpecCat = EventAPISpec.getCategories(language: Language.ru)
////                print("Generated Endpoint apiSpecCat: \(apiSpecCat.endpoint)")
////                
////                let apiSpecLoc = EventAPISpec.getLocation(language: Language.ru)
////                print("Generated Endpoint apiSpecLoc: \(apiSpecLoc.endpoint)")
////                
////                let categories = try await apiManager.getCategories(with: Language.ru)
////                category = categories ?? []
////                
////                let events = try await apiManager.getEvents(with: "msk", Language.ru, "theater", page: "2")
////                eventsTest = events
////                
////                let locationsAPI = try await apiManager.getLocations(with: Language.en)
////                locations = locationsAPI
////                
//                detail = try await apiManager.getEventDetails(eventID: 173607, language: Language.ru)
//               
//            } catch {
//                let errorMessage = "Ошибка загрузки категорий: \(error.localizedDescription)"
//                print(errorMessage)
//            }
//        }
// }
//}
//
//#Preview {
//    TestView()
//}
