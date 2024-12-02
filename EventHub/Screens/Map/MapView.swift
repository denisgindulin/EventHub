//
//  MapView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel: MapViewModel
    @State private var selectedEvent: MapEventModel?
    @EnvironmentObject private var coreDataManager: CoreDataManager
    
    private var isFavorite: Bool {
        coreDataManager.events.contains { event in
            Int(event.id) == self.selectedEvent?.id
        }
    }
    
    //    MARK: - Init
    init() {
        self._viewModel = StateObject(wrappedValue: MapViewModel())
    }
    //    MARK: - Body
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region,
                showsUserLocation: true,
                annotationItems: viewModel.events) { event in
                MapAnnotation(coordinate: event.coords) {
                    EventMarker(event: event)
                        .onTapGesture {
                            selectedEvent = event
                        }
                }
            }
                .edgesIgnoringSafeArea(.all)
            

            VStack {
                HStack {
                    SearchBarForMap(searchText: $viewModel.searchText)
                        .previewLayout(.sizeThatFits)

                    Button(action: {
                        centerOnUserLocation()
                        
                    }) {
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .frame(width: 51, height: 51)
                            .shadow(color: Color(red: 0.83, green: 0.82, blue: 0.85).opacity(0.5), radius: 30, x: 0, y: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.93, green: 0.93, blue: 0.93), lineWidth: 1)
                            )
                            .overlay(
                                Image("myLoc")
                                    .frame(width: 16, height: 16)
                            )
                    }
                    .padding(.leading, 8)
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 25)
                .padding(.top, 80)
                CategoryScroll(categories:
                                viewModel.categories,
                               onCategorySelected: { selectedCategory in
                    viewModel.currentCategory = selectedCategory.category.slug
                    
                })

            }
            
            if let event = selectedEvent {
                let coreDataEvent: ExploreModel = .init(model: event)
                VStack {
                    Spacer()
                    SmallEventCard(
                        image: event.image,
                        date: event.date,
                        title: event.title,
                        place: event.place,
                        showPlace: true,
                        showBookmark: true) {
                            if !isFavorite {
                                coreDataManager.createEvent(event: coreDataEvent)
                            } else {
                                coreDataManager.deleteEvent(eventID: coreDataEvent.id)
                            }
                            
                        }
                        .padding(33)
                        .onTapGesture {
                            selectedEvent = nil
                        }
                    
                }
            }
        }
        .task {
            await viewModel.fetchCategories()
            await viewModel.fetchEvents()
        }
    }
    
    private func centerOnUserLocation() {
        if let location = viewModel.locationManager.location {
            viewModel.region = MKCoordinateRegion(
                center: location,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        }
    }
}

#Preview {
    MapView()
}
