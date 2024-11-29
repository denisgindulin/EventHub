//
//  ProfileEditView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 28.11.2024.
//

import Kingfisher
import SwiftUI

struct ProfileEditeView: View {
    
    let image: String
    @Binding var userName: String
    @Binding var userInfo: String
    
    @State private var editName = false
    @State private var editInfo = false
    @State private var showMore = false
    
    var body: some View {
            ZStack {
                Color.appBackground
                
                VStack {
                    
                    VStack {
                        KFImage(URL(string: image))
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
                    HStack(spacing: 17) {
                        
                        if editName {
                            TextField("\(userName)", text: $userName)
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
                            
                        } else {
                            Text(userName)
                                .airbnbCerealFont( AirbnbCerealFont.medium, size: 24)
                                .frame(height: 28)
                                .padding(.bottom,15)
                            
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
                            .offset(y: -7)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        
                        HStack() {
                            Text("About Me")
                                .airbnbCerealFont( AirbnbCerealFont.medium, size: 18)
                                .frame(height: 65)
                                .padding(.bottom, 20)
                            
                            
                            VStack{
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
                            .offset(y: -10)
                        }
                        
                        
                        ScrollView(showsIndicators: false) {
                            if editInfo {
                                TextEditor(text: $userInfo)
                                    .frame(width: 350, height: 270, alignment: .top)
                                    .padding(20)
                            } else {
                                Text(userInfo)
                                    .airbnbCerealFont( AirbnbCerealFont.book, size: 16)
                                    .frame( alignment: .top)
                                    .lineLimit(4)
                            }
                            Button("Read More") {
                                showMore = true
                            }
                            
                            
//                            Button {
//                                //
//                            } label: {
//                                Image(.vInfo)
//                                    .resizable()
//                                    .frame(width: 5, height: 5,alignment: .bottom)
//                                    .foregroundStyle(.appBlue)
//                            }.padding(.bottom,17)
                            
                            
                        }
                        .frame(height: 191)
                    }
                    SignOutButton(action: { } )
                        .padding(.bottom,137)
                }
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackBarButtonView(foregroundStyle: .black)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal, 20)
            .ignoresSafeArea()
            .sheet(isPresented: $showMore){
                AboutMeInfo(text: userInfo)
            }
            .navigationTitle("Profile")
        
    }
}

#Preview {
    ProfileEditeView(image: "", userName: .constant("Ashfak Sayem"), userInfo: .constant("Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read MoreEnjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More "))
}

