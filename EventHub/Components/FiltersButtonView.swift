//
//  FiltersButtonView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

import SwiftUI

struct FiltersButtonView: View {
    
    @State private var selectedOrder: DisplayOrderType = .alphabetical
    let filterAction: (DisplayOrderType) -> Void
    
    var body: some View {
        Menu {
            ForEach(DisplayOrderType.allCases, id: \.self) { order in
                Button(action: {
                    selectedOrder = order
                    filterAction(order)
                }) {
                    Text(order.name)
                }
            }
        } label: {
            HStack {
                Image(.filter)
                    .resizable()
                    .frame(width: 24, height: 24)
                
                Text("Filters")
                    .frame(width: 35, height: 16, alignment: .leading)
                    .airbnbCerealFont(AirbnbCerealFont.book, size: 12)
                    .foregroundStyle(Color.white)
                    .padding(.trailing, 1)
            }
            .padding(5)
            .frame(width: 75, height: 32.1)
            .background(.appPurple)
            .clipShape(Capsule())
        }
    }
}


#Preview {
    FiltersButtonView() { selectedOrder in
        print("Selected filter: \(selectedOrder.name)")
    }
}
