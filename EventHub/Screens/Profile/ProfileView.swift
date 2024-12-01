//
//  ProfileView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import PhotosUI
import Kingfisher
import SwiftUI

struct ProfileView: View {
    
    
    @StateObject var viewModel: ProfileViewModel
    @State private var showMore = false
    
    init(router: StartRouter) {
        self._viewModel = StateObject(
            wrappedValue: ProfileViewModel(router: router)
        )
    }
    
    var body: some View {
       
            ZStack {
                Color.appBackground
                
                VStack {
                    ToolBarView(title: "Profile".localized, foregroundStyle: .titleFont, isTitleLeading: false)
                        .padding(.bottom, 16)
                    
                    VStack {
                        KFImage(URL(string: viewModel.image)) // Просто показываем фото
                            .placeholder {
                                Image(systemName: "face.smiling.inverse")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 96, height: 96)
                                    .clipShape(Circle())
                            }
                            .resizable()
                            .scaledToFit()
                            .frame(width: 96, height: 96)
                            .clipShape(Circle())
                        
                        Rectangle()
                            .foregroundStyle(.appBackground)
                            .frame(height: 28)
                    }
                    
                    Text(viewModel.name)
                        .airbnbCerealFont( AirbnbCerealFont.medium, size: 24)
                        .frame(height: 28)
                        .padding(.bottom,35)
                    
                    NavigationLink{
                        ProfileEditeView(image: $viewModel.image, userName: $viewModel.name, userInfo: $viewModel.info)
                    } label: {
                        EditButton()
                    }
                    
                    VStack(alignment: .leading) {
                        
                        Text("About Me")
                            .airbnbCerealFont( AirbnbCerealFont.medium, size: 18)
                            .frame(height: 65)
                            .padding(.bottom, 20)
                        ScrollView(showsIndicators: false) {
                            
                            Text(viewModel.info)
                                .airbnbCerealFont( AirbnbCerealFont.book, size: 16)
                                .frame( alignment: .top)
                                .lineLimit(4)

                            Button {
                                showMore = true
                            } label: {
                                Text("Read More".localized)
                                    .foregroundStyle(.appBlue)
                            }

//                            Button{
//                                //
//                            } label: {
//                                Image(.vInfo)
//                                    .resizable()
//                                    .frame(width: 5, height: 5,alignment: .bottom)
//                                    .foregroundStyle(.appBlue)
//                            }.padding(.bottom,17)
                        }
                        .frame(height: 191)
                    }.offset(y: 20)
                    
                    SignOutButton(action: { viewModel.signOut() } )
                        .padding(.bottom,107)
                }
            }
//            .navigationTitle("Profile")
//            .navigationTitle(navTitle)

//            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showMore) {
                AboutMeInfo(text: viewModel.info)
            }
            .padding(.horizontal, 20)
            .ignoresSafeArea()
            .offset(y: 25)
        
    }
}

#Preview {
    ProfileView(router: StartRouter())
}

