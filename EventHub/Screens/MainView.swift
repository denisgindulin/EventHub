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
                Color.white //     App  Color Background
                VStack {
                    CustomToolBar(title: viewModel.currentPosition, magnifierColor: .white)
                    ScrollView(showsIndicators: false) {
                            CategoryScroll(colors: viewModel.categoryColors, categoryNames: viewModel.categories, categoryImages: viewModel.categoryImages)
                                .padding(.bottom, 22)
                            
                            MainCategorySectionView(title: "Upcomimg Events")
                                .padding(.bottom, 10)
                            
                            ScrollEventCardsView(events: nil)
                                .padding(.bottom, 10)
                            
                            MainCategorySectionView(title: "Nearby You")
                                .padding(.bottom, 10)
                            
                            ScrollEventCardsView(events: [Event.example, Event.example])
                                .padding(.bottom, 150) // for TabBar
                    }
                    .offset(y: -30)
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
