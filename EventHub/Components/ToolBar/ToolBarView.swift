//
//  ToolBar.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 18.11.2024.
//

import SwiftUI

struct ToolBarView: View {
    var showBackButton: Bool = false
    var backButtonAction: (() -> Void)?
    
    var showRightButton: Bool = false
    var rightButtonAction: (() -> Void)?
    var rightButtonImage: ImageResource? = .bookmark
    var title: String
    
    var body: some View {
        HStack {
            if showBackButton, let backButtonAction = backButtonAction {
                Button(action: {
                    backButtonAction()
                }) {
                    Image(systemName: "arrowLeft")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 38, height: 38)
                        .foregroundStyle(.appBackground)
                }
                .padding(.leading, 16)
            } else {
                Spacer().frame(width: 50)
            }
            
           
            Text(title)
                .airbnbCerealFont(AirbnbCerealFont.medium, size: Drawing.fontSize)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal)
                .lineLimit(1)
                .foregroundStyle(.basicBlue)
            
            if showRightButton, let rightButtonAction = rightButtonAction {
                Button(action: {
                    rightButtonAction()
                }) {
                    Image(rightButtonImage ?? .rulesIcon)
                        .frame(width: 38, height: 38)
                        .foregroundStyle(.basicBlack)
                }
                .padding(.trailing, 16)
            } else {
                Spacer().frame(width: 50)
            }
        }
        .frame(height: 44)
        .background(Color.basicBackground)
    }
}

#Preview {
    VStack {
        ToolBarView(
            showBackButton: true,
            backButtonAction: { print("Back button pressed") },
            showRightButton: true,
            rightButtonAction: { print("Right button pressed") },
            title: "Custom NavBar"
        )
        
        Spacer()
    }
}

