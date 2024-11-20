//
//  BackgroundMainView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

struct BackgroundMainView: View {
    var body: some View {
        ZStack {
            Color.white
            RoundedRectangle(cornerRadius: 33)
                .foregroundStyle(Color.appBlue)
                .frame(height: 350)
                .offset(y: -390)
       }
                      .ignoresSafeArea()
    }
}

#Preview {
    BackgroundMainView()
}
