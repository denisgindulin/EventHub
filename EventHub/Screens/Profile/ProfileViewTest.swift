//
//  ProfileViewTest.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 26.11.2024.
//

//import Kingfisher
//import SwiftUI
//
//struct ProfileViewTest: View {
//    @ObservedObject var model: ProfileViewModel
//    
//    @State private var showMore = false
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                Color.appBackground
//                
//                VStack {
//                    Text("Profile")
//                        .foregroundStyle(.black)
//                        .airbnbCerealFont( AirbnbCerealFont.medium, size: 24)
//                        .frame(height: 80)
//                    
//                    VStack {
//                        KFImage(URL(string: model.image))
//                            .placeholder {
//                                Image(systemName: "face.smiling.inverse")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 96, height: 96)
//                                    .clipShape(Circle())
//                            }
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 96, height: 96)
//                            .clipShape(Circle())
//                        
//                        Rectangle()
//                            .foregroundStyle(.appBackground)
//                            .frame(height: 28)
//                    }
//                    
//                    Text(model.name)
//                        .airbnbCerealFont( AirbnbCerealFont.medium, size: 24)
//                        .frame(height: 28)
//                        .padding(.bottom,15)
//                    
//                    NavigationLink{
//                        ProfileEditeView(image: model.image, userName: $model.name, userInfo: $model.info)
//                    } label: {
//                        EditButton()
//                    }
//                    
//                    VStack(alignment: .leading) {
//                        
//                        Text("About Me")
//                            .airbnbCerealFont( AirbnbCerealFont.medium, size: 18)
//                            .frame(height: 65)
//                            .padding(.bottom, 20)
//                        ScrollView(showsIndicators: false) {
//                            
//                            Text(model.info)
//                                .airbnbCerealFont( AirbnbCerealFont.book, size: 16)
//                                .frame( alignment: .top)
//                                .lineLimit(4)
//                            
//                            Button("Read More") {
//                                showMore = true
//                            }
//                            
////                            Button{
////                                //
////                            } label: {
////                                Image(.vInfo)
////                                    .resizable()
////                                    .frame(width: 5, height: 5,alignment: .bottom)
////                                    .foregroundStyle(.appBlue)
////                            }.padding(.bottom,17)
//                        }
//                        .frame(height: 191)
//                    }
//                    SignOutButton(action: { } )
//                        .padding(.bottom,137)
//                }
//            }
//            .sheet(isPresented: $showMore) {
//                AboutMeInfo(text: model.info)
//            }
//            .padding(.horizontal, 20)
//            .ignoresSafeArea()
//            
//        }
//    }
//}
//
//#Preview {
//    ProfileViewTest(model: ProfileViewModel(router: StartRouter()))
//}
