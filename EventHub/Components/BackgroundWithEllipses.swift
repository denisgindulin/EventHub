//
//  BackgroundWithEllipses.swift
//  EventHub
//
//  Created by Денис Гиндулин on 20.11.2024.
//

import SwiftUI

struct BackgroundWithEllipses: View {
    var body: some View {
        Image(.bgWithStaticEllipses)
            .resizable()
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
            .ignoresSafeArea()
        
    }
}

#Preview {
    BackgroundWithEllipses()
}
