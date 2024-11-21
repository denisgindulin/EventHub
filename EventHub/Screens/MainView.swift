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
                Color.appMainBackground // zIndex // UIScreen.main.bounds.width
                VStack {
                    ZStack {
                        CustomToolBar(title: viewModel.currentPosition, magnifierColor: .white, colors: viewModel.categoryColors, categories: viewModel.categories, pictures: viewModel.categoryPictures)
                        CategoryScroll(colors: viewModel.categoryColors, categoryNames: viewModel.categories, categoryImages: viewModel.categoryPictures)
                            .offset(y: 92)
                    }
                    .zIndex(1)
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            MainCategorySectionView(title: "Upcomimg Events")
                                .padding(.bottom, 10)
                            
                            ScrollEventCardsView(events: nil)
                                .padding(.bottom, 10)
                            
                            MainCategorySectionView(title: "Nearby You")
                                .padding(.bottom, 10)
                            
                            ScrollEventCardsView(events: [Event.example, Event.example])
                                .padding(.bottom, 150) // for TabBar
                        }
                        .offset(y: 25)
                    }
                    .offset(y: -10)
                    .zIndex(0)
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
