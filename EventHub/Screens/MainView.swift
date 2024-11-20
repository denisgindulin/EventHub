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
                BackgroundMainView()
                ScrollView(showsIndicators: false) {
                    VStack {
                        
                        HStack{ // custom NavBar ?>
                            VStack(alignment: .leading) {
                                Button {
                                    // redefinition geo
                                } label: {
                                    Text("Current Location")
                                        .airbnbCerealFont( AirbnbCerealFont.book, size: 12)
                                        .frame(width: 99, height: 14, alignment: .leading)
                                        .foregroundStyle(Color.white)
                                        .opacity(0.7)
                                    Image(systemName: "arrowtriangle.down.fill")
                                        .resizable()
                                        .frame(width: 10, height: 5)
                                        .foregroundStyle(Color.white)
                                        .opacity(0.7)
                                }
                                
                                Text(viewModel.currentPosition)
                                    .foregroundStyle(Color.white)
                                    .airbnbCerealFont(AirbnbCerealFont.book, size: 13)
                            }
                            
                            Spacer()
                            
                            Image(.bell)
                        }
                        .padding(.horizontal,24) // <Nav bar ?
                        
                        SearchBarView(magnifierColor: .white)
                        
                        CategoryScroll(colors: viewModel.categoryColors, categoryNames: viewModel.categories, categoryImages: viewModel.categoryImages) // offset leading
                            .padding(.bottom, 22)
                            .padding(.leading, 24) // geometry ?
                        
                        MainCategorySectionView(title: "Upcomimg Events")
                            .padding(.bottom, 10)
                        
                        ScrollEventCardsView(events: nil)
                            .padding(.bottom, 10)
                            .padding(.leading, 24) // geometry ?
                            
                        MainCategorySectionView(title: "Nearby You")
                            .padding(.bottom, 10)
                        
                        ScrollEventCardsView(events: [Event.example, Event.example])
                            .padding(.bottom, 150) // for TabBar
                            .padding(.leading, 24) // geometry ?
                        
                    }
                }
                
            }
        }
            
    }
}

#Preview {
    MainView()
}
