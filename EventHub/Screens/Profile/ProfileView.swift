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
    @State private var avatarImage: UIImage = UIImage(resource: .avatar)
    
    init(router: StartRouter) {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(router: router))
    }
    
    var body: some View {
        ZStack {
            Color.appBackground
            
            VStack(spacing: 50) {
                
                
                VStack {
                    ToolBarView(title: "Profile".localized, foregroundStyle: .titleFont, isTitleLeading: false)
                        .padding(.bottom, 16)
                    KFImage(URL(string: firebaseManager.userAvatar ?? ""))
                        .placeholder {
                            Image(uiImage: avatarImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 96, height: 96)
                                .clipShape(Circle())
                        }
                        .resizable()
                        .scaledToFill()
                        .frame(width: 96, height: 96)
                        .clipShape(Circle())
                    
                    VStack(alignment: .center, spacing: 15) {
                        Text(firebaseManager.user?.name ?? "No Name")
                            .airbnbCerealFont(.book, size: 24)
                        
                        NavigationLink{
                            ProfileEditeView(viewModel: viewModel,
                                             image: $firebaseManager.name,
                                             userName: $firebaseManager.name,
                                             userInfo: $firebaseManager.info,
                                             avatarImage: $avatarImage)
                        } label: {
                            EditButton()
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("About Me")
                        .airbnbCerealFont( AirbnbCerealFont.medium, size: 18)
                    
                    VStack(alignment: .leading) {
                        Text(firebaseManager.user?.info ?? "No Info")
                            .airbnbCerealFont( AirbnbCerealFont.book, size: 16)
                            .lineLimit(4)
                        
                        Button {
                            showMore = true
                        } label: {
                            Text("Read More".localized)
                                .foregroundStyle(.appBlue)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                SignOutButton(action: { viewModel.signOut() } )
                    .padding(.bottom, 30)
            }
        }
        .sheet(isPresented: $showMore) {
            AboutMeInfo(text: $firebaseManager.info.wrappedValue)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    ProfileView(router: StartRouter())
}

