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
            .frame(width: .infinity, 
                   height: .infinity)
            .ignoresSafeArea()
        
    }
}

#Preview {
    BackgroundWithEllipses()
}
