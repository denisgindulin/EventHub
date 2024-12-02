//
//  BlueCapsuleButtonWithArrow.swift
//  EventHub
//
//  Created by Денис Гиндулин on 21.11.2024.
//

import SwiftUI

struct BlueCapsuleButtonWithArrow: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                ZStack {
                    Text(text.uppercased())
                        .airbnbCerealFont(.medium)
                        .minimumScaleFactor(0.5)
                    HStack {
                        Spacer()
                        Image(systemName: "arrow.right")
                            .scaleEffect(0.7)
                            .padding(4)
                            .background(.mediumBlue)
                            .clipShape(Circle())
                    }
                }
            }
        }
        .padding(11)
        .frame(maxWidth: UIScreen.main.bounds.width * 191/375 , maxHeight: UIScreen.main.bounds.width * 72/812)
        .background(.appBlue)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    BlueCapsuleButtonWithArrow(text: "READ") {
        print("Action")
    }
}
