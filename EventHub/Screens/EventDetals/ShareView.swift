//
//  ShareView.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 25.11.2024.
//

import SwiftUI

struct ShareView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        BottomSheetView(isOpen: $isPresented, maxHeight: 360) {
            VStack(alignment: .leading) {
                Text("Share with friends")
                    .airbnbCerealFont(.medium, size: 24)
                    .multilineTextAlignment(.leading)
                SocialNetworksView()
                Spacer()
                Button {
                    isPresented = false
                } label: {
                    Text("Cancel".uppercased())
                        .padding(.vertical, 19)
                        .frame(maxWidth: .infinity)
                        .airbnbCerealFont(.book)
                        .foregroundStyle(.bottomSheetCancel)
                        .background(.bottomSheetCancelBg)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 43)
            }
            .padding(.horizontal, 24)
        }
    }
}
