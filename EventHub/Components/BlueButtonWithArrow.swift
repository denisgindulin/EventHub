//
//  BlueButtonWithArrow.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 20.11.2024.
//

import SwiftUI

struct BlueButtonWithArrow: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                ZStack {
                    Text(text.uppercased())
                        .airbnbCerealFont(.bold)
                        .minimumScaleFactor(0.5)
                    HStack {
                        Spacer()
                        Image(systemName: "arrow.right")
                            .padding(8)
                            .background(.mediumBlue)
                            .clipShape(Circle())
                    }
                }
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, maxHeight: 58)
        .background(.appBlue)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        //.padding(.horizontal, 28)

    }
}

#Preview {
    BlueButtonWithArrow(text: "Sign Up") {
        print("Action")
    }
}
