//
//  EventCardView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI
import Kingfisher

struct EventCardView: View {
    @EnvironmentObject private var coreDataManager: CoreDataManager
    private var isFavorite: Bool {
        coreDataManager.events.contains { event in
            Int(event.id) == self.event.id
        }
    }
    
    let test: [Image] = [Image("avatarPhoto1"), Image("avatarPhoto2"), Image("avatarPhoto3"), Image("avatarPhoto4"), Image("avatarPhoto5"), Image("avatarPhoto6"), Image("avatarPhoto7"), Image("avatarPhoto8")]
    let visitorsCount = Int.random(in: 0...12)
    
    let event: ExploreEvent
    var showDetail: (Int) -> Void
    
    var body: some View {
        
        ZStack {
            Color.white
            VStack(alignment: .leading) {
                
                ZStack(alignment: .top) {
                    if let imageUrl = event.image, let url = URL(string: imageUrl) {
                        KFImage(url)
                            .placeholder {
                                ShimmeringImageView()
                            }
                            .resizable()
                            .frame(width: 218, height: 131)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        Image(.cardImg1)
                            .resizable()
                            .frame(width: 218, height: 131)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    VStack {
                        Button {
                            if isFavorite {
                                coreDataManager.deleteEvent(eventID: event.id)
                            } else {
                                coreDataManager.createEvent(event: event)
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.appOrangeSecondary)
                                    .opacity(0.7)
                                Image(isFavorite ? .bookmarkFill : .bookmarkOverlay)
                                    .resizable()
                                    .frame(width: 14, height: 14)
                                    .foregroundStyle(.appRed)
                            }
                        }
                    }
                    .padding(.top,9)
                    .offset(x: 85)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 45, height: 45)
                            .foregroundStyle(.appOrangeSecondary)
                            .opacity(0.7)
                        VStack {
                            Text(event.date.formattedDate(format: "dd\nMMM"))
                                .foregroundStyle(.appDateText)
                                .airbnbCerealFont(AirbnbCerealFont.book, size: 18)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.top, 9)
                    .offset(x: -77)
                }
                .padding(.top, 10)
                
                Text(event.title)
                    .airbnbCerealFont(AirbnbCerealFont.medium, size: 18)
                    .frame(width: 207, height: 21, alignment: .leading)
                    .padding(.bottom,10)
                
            
                    HStack {
                        ZStack {
                            ForEach(getVisitorsImages(visitorsCount: visitorsCount).indices, id:\.self) { index in
                                
                                let visitors = getVisitorsImages(visitorsCount: visitorsCount)
                                
                                visitors[index]
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .clipShape(Circle())
                                    .overlay {
                                        Circle().stroke(style: StrokeStyle(lineWidth: 1))
                                            .foregroundStyle(Color.white)
                                    }
                                    .offset(x: getOffset(index: index, visitors: getVisitorsImages(visitorsCount: visitorsCount).count))
                            }
                        }
                        
                        Button {
                            // show visitors
                        } label: {
                            HStack(spacing: 1) {
                                Text(visitorsCount > 3 ? "+" : "")
                                    .airbnbCerealFont(AirbnbCerealFont.book, size: 12)
                                
                                Text(checkTo(visitorsCount: visitorsCount) == 0
                                     ? ""
                                     : String(checkTo(visitorsCount: visitorsCount)))
                                .airbnbCerealFont(AirbnbCerealFont.book, size: 12)
                                
                                Text(visitorsCount > 0 ? " Going" : "")
                                    .airbnbCerealFont(AirbnbCerealFont.book, size: 12)
                            }
                        }
                        .padding(.leading, 25)
                    }
               
                
                
                Button {
                    // show map
                } label: {
                    HStack {
                        Image(.mapPin)
                            .resizable()
                            .foregroundStyle(.geolocationText)
                            .frame(width: 16, height: 16)
                        Text(event.adress)
                            .airbnbCerealFont(AirbnbCerealFont.book, size: 13)
                            .foregroundStyle(.geolocationText)
                    }
                    .frame(width: 185, height: 17, alignment: .leading)
                }
            }
            .padding(.top,9)
            .padding(.horizontal, 9)
            .padding(.bottom, 15)
        }
        .onTapGesture {
            showDetail(event.id)
        }
        .frame(width: 237, height: 255)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
    }
    
    private func getOffset(index: Int, visitors: Int) -> CGFloat {
        var offset = 0
        let ratio = 15
        
        if visitors == 1 {
            offset = 0
        } else if visitors == 2 {
            switch index {
            case 0: offset = ratio
            default: offset = 0
            }
        } else if visitors == 3 {
            switch index {
            case 0: offset = 2 * ratio
            case 1: offset = ratio
            default: offset = 0
            }
        }
        return CGFloat(offset)
    }
    
    private func checkRemainingNumberOfVisitors(visitors: [Visitor]) -> Int {
        switch visitors.count {
        case 0: return 0
        case 1: return 0
        case 2: return 0
        case 3: return 0
        default: return visitors.count-3
        }
    }
    
    private func checkTo(visitorsCount: Int) -> Int {
       
        switch visitorsCount {
        case 0: return 0
        case 1: return 0
        case 2: return 0
        case 3: return 0
        default: return visitorsCount-3
        }
        
    }
    
    private func getVisitorsImages( visitorsCount: Int) -> [Image] {
        var images: [Image] = []
        var  avatars = test
        
        if visitorsCount > 3 {
            for i in 0...2 {
                avatars.shuffle()
                let image = avatars[i]
                images.append(image)
            }
        }
        
        if visitorsCount == 3 {
            avatars.shuffle()
            for image in avatars {
                images.append(image)
            }
        }
        
        if visitorsCount == 2 {
            avatars.shuffle()
            for image in avatars {
                images.append(image)
            }
        }
        if visitorsCount == 1 {
            avatars.shuffle()
            for image in avatars {
                images.append(image)
            }
        }
        
        return images
    }
    
    private func getVisitorsAvatars(visitors: [Visitor]) -> [Visitor] {
        var randomThreeVisitors: [Visitor] = []
        
        if visitors.count > 3 {
            for i in 0...2 {
                let visitor = visitors[i]
                randomThreeVisitors.append(visitor)
            }
        }
        
        if visitors.count == 3 {
            for visitor in visitors {
                randomThreeVisitors.append(visitor)
            }
        }
        
        if visitors.count == 2 {
            for visitor in visitors {
                randomThreeVisitors.append(visitor)
            }
        }
        if visitors.count == 1 {
            for visitor in visitors {
                randomThreeVisitors.append(visitor)
            }
        }
        return randomThreeVisitors
    }
    
    
}



#Preview {
    EventCardView(event: ExploreEvent.example, showDetail: {_ in })
}
