//
//  MainView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct MainView: View {
    
    let viewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.appMainBackground
                VStack {
                    CustomToolBar(title: viewModel.currentPosition, magnifierColor: .white, colors: viewModel.categoryColors, categories: viewModel.categories, pictures: viewModel.categoryPictures)
                    ScrollView(showsIndicators: false) {
                            
                            MainCategorySectionView(title: "Upcomimg Events")
                                .padding(.bottom, 10)
                            
                            ScrollEventCardsView(events: nil)
                                .padding(.bottom, 10)
                            
                            MainCategorySectionView(title: "Nearby You")
                                .padding(.bottom, 10)
                            
                            ScrollEventCardsView(events: [Event.example, Event.example])
                                .padding(.bottom, 150) // for TabBar
                    }
                    .navigationBarHidden(true)
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    MainView()
}
