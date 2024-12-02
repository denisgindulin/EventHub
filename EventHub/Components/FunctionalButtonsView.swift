//
//  FunctionalButtonsView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 25.11.2024.
//

import SwiftUI

struct FunctionalButtonsView: View {
    
    let names: [String]
    let actions: [() -> Void]
    @Binding var chooseButton: String
    
    var body: some View {
        HStack {
            ForEach(Array(names.enumerated()), id: \.offset) { index, name in
                Button {
                    chooseButton = name
                    if index < actions.count {
                        actions[index]()
                    }
                } label: {
                    ZStack {
                        Capsule()
                            .foregroundStyle(.appBlue)
                            .frame(width: 106, height: 39)
                        Text(name.uppercased())
                            .airbnbCerealFont(AirbnbCerealFont.medium, size: 15)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    FunctionalButtonsView(names: ["Today","Films", "Lists"], actions: [{}], chooseButton: .constant("today"))
}
