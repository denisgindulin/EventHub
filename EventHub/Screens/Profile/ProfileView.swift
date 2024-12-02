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
    
    @EnvironmentObject var firebaseManager: FirebaseManager
    @StateObject var viewModel: ProfileViewModel
    @State private var showMore = false
    
    @State private var name: String = ""
    @State private var info: String = ""
    
    init(router: StartRouter) {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(router: router))
    }
    
    var body: some View {
            ZStack {
                Color.appBackground
                
                VStack(alignment: .leading) {
                    VStack(alignment: .center, spacing: 21) {
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
                        
                        VStack(alignment: .center, spacing: 15) {
                            Text(firebaseManager.user?.name ?? "No Name")
                                .airbnbCerealFont(.book, size: 24)
                            
                            NavigationLink{
                                ProfileEditeView(viewModel: viewModel,
                                                 image: $viewModel.image,
                                                 userName: $viewModel.name,
                                                 userInfo: $viewModel.info)
                            } label: {
                                EditButton()
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 65) {
                        Text("About Me")
                            .airbnbCerealFont( AirbnbCerealFont.medium, size: 18)
                            .padding(.bottom, 20)
                        
                        ScrollView(showsIndicators: false) {
                            Text(firebaseManager.user?.info ?? "No Info")
                                .airbnbCerealFont( AirbnbCerealFont.book, size: 16)
                                .lineLimit(4)
                            
                            Button("Read More") {
                                showMore = true
                            }
                        }
                        .frame(height: 191)
                    }.offset(y: 20)
                    
                    SignOutButton(action: { viewModel.signOut() } )
                        .padding(.bottom,107)
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showMore) {
                AboutMeInfo(text: viewModel.info)
            }
            .padding(.horizontal, 20)
            .ignoresSafeArea()
            .offset(y: 25)
            .onAppear {
                print(name)
                name = firebaseManager.user?.name ?? "No Name"
                print(name)
            }
    }
}

#Preview {
    ProfileView(router: StartRouter())
}

