//
//  EventCardView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct EventCardView: View {
    
    let event: Event
    
    var dayAndMounthFromDate: [String] {
        event.date.components(separatedBy: " ")
    }
    var body: some View {
        
        ZStack {
            Color.green // white
            VStack(alignment: .leading) {
                
                if event.image != nil {
                    ZStack {
                        Image(.cardImg1) // Image ?!?
                            .resizable()
                            .frame(width: 219, height: 133)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.top, 9)
                            .padding(.bottom,14)
                        
                        Button {
                            // add bookmark
                            print("Bookmark hi") // don t working
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.gray) //color
                                    .opacity(0.7)
                                Image(event.isFavorite ? .bookmark : .bookmarkOverlay)
                                    .resizable()
                                    .frame(width: 14, height: 14)
                            }
                            .offset(x: 85,y: -45)
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 45, height: 45)
                                .foregroundStyle(.gray)//color
                                .opacity(0.7)
                            //  .blur(radius: 3) ??
                            VStack {
                                Text(dayAndMounthFromDate[0])
                                    .airbnbCerealFont(AirbnbCerealFont.book, size: 18)
                                Text(dayAndMounthFromDate[1].uppercased())
                                    .font(.system(size: 10))
                            }
                        }
                        .offset(x: -75, y: -35)
                    }
                } else {
                    Image(systemName: "xmark.square.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width:227, height: 145)
                        .padding(.top,9)
                        .padding(.bottom,14)
                }
                
                Text(event.title)
                    .airbnbCerealFont(AirbnbCerealFont.medium, size: 18)
                    .frame(width: 207, height: 21, alignment: .leading)
                    .padding(.bottom, 12)
                
#warning("image for avatars")
                if let visitors = event.visitors {
                    HStack {
                        ForEach(getThreeVisitorsAvatars(visitors: visitors)) { avatar in
                            
                            Image(.visitor) // avatar image
                                .resizable()
                                .frame(width: 24, height: 24)
                                .clipShape(Circle())
                                .overlay {
                                    Circle().stroke(style: StrokeStyle(lineWidth: 1))
                                        .foregroundStyle(Color.white)
                                }
                        }
                        Button {
                            // show visitors
                        } label: {
                            HStack(spacing: 1) {
                                Text(visitors.count > 3 ? "+" : "")
                                    .airbnbCerealFont(AirbnbCerealFont.book, size: 12)
                                
                                Text(checkRemainingNumberOfVisitors(visitors: visitors) == 0 ? "" : String(checkRemainingNumberOfVisitors(visitors: visitors)))
                                    .airbnbCerealFont(AirbnbCerealFont.book, size: 12)
                                
                                Text(visitors.count > 0 ? " Going" : "")
                                    .airbnbCerealFont(AirbnbCerealFont.book, size: 12)
                            }
                        }
                    }
                }
                Button {
                    // show map button ?
                } label: {
                    HStack {
                        Image(.mapPin)
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text(event.adress)
                            .airbnbCerealFont(AirbnbCerealFont.book, size: 13)
                            .foregroundStyle(.gray) //Color
                    }
                    .frame(width: 190, height: 17)
                    .padding(.bottom, 9)
                }
            }
        }
        .frame(width: 237, height: 255)
        .clipShape(RoundedRectangle(cornerRadius: 18))
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
    
    private func getThreeVisitorsAvatars(visitors: [Visitor]) -> [Visitor] {
        var randomThreeVisitors: [Visitor] = []
        
        if visitors.count > 3 {
            for i in 0...2 {
             let visitor = visitors[i]
                randomThreeVisitors.append(visitor)
            }
        }
        return randomThreeVisitors
    }
    
}

#Preview {
    EventCardView(event: Event.example)
}
