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
                
                CategoryScroll(categories:
                                viewModel.categories,
                               onCategorySelected: { selectedCategory in
                    viewModel.currentCategory = selectedCategory.category.slug
                    
                })
                
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        centerOnUserLocation()
                    }) {
                        Image(systemName: "location.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                            .padding()
                            .background(Circle().fill(Color.white).shadow(radius: 3))
                    }
                    .padding()
                }
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

