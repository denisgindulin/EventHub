//
//  ProfileEditView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 28.11.2024.
//

import Kingfisher
import SwiftUI

struct ProfileEditeView: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.dismiss) var dismiss
    
    @Binding var image: String
    @Binding var userName: String
    @Binding var userInfo: String
    
    @State private var editName = false
    @State private var editInfo = false
    @State private var showMore = false
    
    @State private var showImagePicker = false
    @Binding var avatarImage: UIImage
    
    var body: some View {
        ZStack {
            Color.appBackground
            
            VStack(spacing: 90) {
                VStack {
                    ToolBarView(title: "Profile".localized, foregroundStyle: .titleFont, isTitleLeading: false)
                        .padding(.bottom, 16)
                    
                    VStack {
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
                    }
                    .onTapGesture {
                        showImagePicker = true
                    }
                    .sheet(isPresented: $showImagePicker) { ImagePicker(image: $avatarImage) }
                    
                    HStack(spacing: 17) {
                        
                        if editName {
                            HStack {
                                TextField("\(firebaseManager.user?.name ?? "")", text: $userName)
                                    .textFieldStyle(.roundedBorder)
                                
                                VStack {
                                    Button {
                                        editName = false
                                    } label: {
                                        Image(systemName: "checkmark")
                                            .resizable()
                                            .foregroundStyle(.appBlue)
                                            .frame(width: 22, height: 22, alignment: .center)
                                    }
                                }
                            }
                        } else {
                            Text(userName)
                                .airbnbCerealFont( AirbnbCerealFont.medium, size: 24)
                            
                            VStack {
                                Button {
                                    editName = true
                                } label: {
                                    Image(.edit)
                                        .resizable()
                                        .foregroundStyle(.appBlue)
                                        .frame(width: 22, height: 22, alignment: .center)
                                }
                            }
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 40) {
                    
                    HStack {
                        Text("About Me")
                            .airbnbCerealFont( AirbnbCerealFont.medium, size: 18)
                        
                        VStack(alignment: .leading) {
                            Button {
                                editInfo.toggle()
                            } label: {
                                if editInfo {
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .foregroundStyle(.appBlue)
                                        .frame(width: 22, height: 22, alignment: .center)
                                } else {
                                    Image(.edit)
                                        .resizable()
                                        .foregroundStyle(.appBlue)
                                        .frame(width: 22, height: 22, alignment: .center)
                                }
                            }
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        if editInfo {
                            TextEditor(text: $userInfo)
                        } else {
                            Text(userInfo)
                                .airbnbCerealFont( AirbnbCerealFont.book, size: 16)
                                .lineLimit(4)
                        }
                        
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
                
                SignOutButton(action: { } )
                    .padding(.bottom, 30)
            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackBarButtonView(foregroundStyle: .black)
            }
        }
        .sheet(isPresented: $showMore){
            AboutMeInfo(text: userInfo)
        }
        .onDisappear {
            print("updateUserProfile")
            viewModel.updateUserProfile(name: userName,
                                        info: userInfo,
                                        image: "")
            
            firebaseManager.loadUserData(userId: viewModel.currentUser?.uid ?? "")
        }
    }
}
