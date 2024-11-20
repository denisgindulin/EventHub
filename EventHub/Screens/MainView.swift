//
//  MainView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct CustomToolBar: View {
    var body: some View {
        VStack {
            HStack{
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
                    
                    Text("NY usanfirnetto"/*viewModel.currentPosition*/)
                        .foregroundStyle(Color.white)
                        .airbnbCerealFont(AirbnbCerealFont.book, size: 13)
                }
                
                Spacer()
                
                Button{
                    // show natifications
                } label: {
                    Image(.bell)
                }
            }
            .padding(.horizontal,24)
            .padding(.bottom, 10)
            
            SearchBarView(magnifierColor: .white)
                .padding(.horizontal,24)
        }
        .frame(width: .infinity, height: 220)
        .padding(0)
        .background(.appBlue)
        .clipShape(RoundedCorner(radius: 30, corners: [.bottomLeft,.bottomRight]))
}
    
}
struct MainView: View {
    
    let viewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white //     App  Color Background
                VStack {
                            CustomToolBar()
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
