//
//  EventCardView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI
import Kingfisher

struct EventCardView: View {
    
    let event: Event
    var showDetail: (Int) -> Void
    
    
    var body: some View {
        
        ZStack {
            Color.white // white
            VStack(alignment: .leading) {
                ZStack {
                    if let imageUrl = event.image, let url = URL(string: imageUrl) {
                        KFImage(url)
                            .placeholder {
                                ShimmerView(ratio: 1)
                                    .scaledToFit()
                                    .frame(width: 219, height: 133)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .resizable()
                            .frame(width: 219, height: 133)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.top, 9)
                            .padding(.bottom, 14)
                    } else {
                        Image(.cardImg1)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 227, height: 145)
                            .padding(.top, 9)
                            .padding(.bottom, 14)
                    }
                    
                    VStack {
                        Button {
                            // add bookmark
                            print("bookmark trigg")
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.appOrangeSecondary)
                                    .opacity(0.7)
                                Image(event.isFavorite ? .bookmarkRedFill : .bookmarkOverlay)
                                    .resizable()
                                    .frame(width: 14, height: 14)
                            }
                        }
                    }
                    .offset(x: 86,y: -46)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 45, height: 45)
                            .foregroundStyle(.appOrangeSecondary)
                            .opacity(0.7)
                        //  .blur(radius: 3) ??
                        VStack {
                            Text(event.date)
                                .foregroundStyle(.appDateText)
                                .airbnbCerealFont(AirbnbCerealFont.book, size: 18)
                                .multilineTextAlignment(.center)
                            
                            //                                Text(dayAndMonth[1].uppercased())
                            //                                    .font(.system(size: 10))
                            //                                    .foregroundStyle(.appDateText)
                        }
                    }
                    .offset(x: -78, y: -38)
                }
                Text(event.title)
                    .airbnbCerealFont(AirbnbCerealFont.medium, size: 18)
                    .frame(width: 207, height: 21, alignment: .leading)
                    .padding(.bottom, 12)
                

                if let visitors = event.visitors {
                    HStack{
                        ZStack {
                            ForEach(getVisitorsAvatars(visitors: visitors).indices, id:\.self) { index in
                                
                                let visitors = getVisitorsAvatars(visitors: visitors)
                                
                                let imageURL = visitors[index].image
                                let url = URL(string: imageURL)
                                
                                KFImage(url)
                                    .placeholder {
                                        ShimmerView(ratio: 1)
                                            .scaledToFit()
                                            .frame(width: 24, height: 24)
                                            .clipShape(Circle())
                                    }
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .clipShape(Circle())
                                    .overlay {
                                        Circle().stroke(style: StrokeStyle(lineWidth: 1))
                                            .foregroundStyle(Color.white)
                                    }
                                    .offset(x: getOffset(index: index, visitors: getVisitorsAvatars(visitors: visitors).count))
                                
                                
                                //                                } else {
                                //                                    Image(.visitor) // example image
                                //                                        .resizable()
                                //                                        .frame(width: 24, height: 24)
                                //                                        .clipShape(Circle())
                                //                                        .overlay {
                                //                                            Circle().stroke(style: StrokeStyle(lineWidth: 1))
                                //                                                .foregroundStyle(Color.white)
                                //                                        }
                                //                                        .offset(x: getOffset(index: index, visitors: getVisitorsAvatars(visitors: visitors).count))
                                //                                }
                                
                                
                                
                                
                                
                                
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
                        .padding(.leading, 25)
                    }
                }
                
                
                Button {
                    // show map button ?
                } label: {
                    HStack {
                        Image(.placePin)
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
    EventCardView(event: Event.example, showDetail: {_ in })
}
