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
    
    
    init() {
        self._viewModel = StateObject(wrappedValue: MapViewModel())
    }
    
    var body: some View {
           Map(
               coordinateRegion: $viewModel.region,
               showsUserLocation: true, 
               annotationItems: viewModel.events
           ) { event in
               MapAnnotation(coordinate: event.coords) {
                   VStack {
                       Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
                           .foregroundColor(viewModel.isFavorite ? .yellow : .blue)
                       Text(event.title)
                           .font(.caption)
                   }
               }
           }
           .edgesIgnoringSafeArea(.all)
           .task {
               await viewModel.fetchEvents()
           }
    }
    
    func showEventPreview(_ event: ExploreEvent) {
        // Логика для отображения предпросмотра события
    }
}


