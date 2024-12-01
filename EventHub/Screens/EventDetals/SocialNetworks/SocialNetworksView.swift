//
//  SocialNetworksView.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 25.11.2024.
//

import SwiftUI

struct SocialNetworksView: View {
    @StateObject private var viewModel = SocialNetworksViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 23) {
            ForEach(viewModel.socialNetworks) { socialNetwork in
                Button {
                    viewModel.share(in: socialNetwork)
                } label: {
                    VStack(spacing: 11) {
                        Image(socialNetwork.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 40)
                        Text(socialNetwork.text.localized)
                            .font(.caption)
                            .airbnbCerealFont(.book, size: 13)
                            .foregroundStyle(Color(.label))
                    }
                }
            }
        }
    }
}
