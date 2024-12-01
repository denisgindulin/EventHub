//
//  SearchBarView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct SearchBarView: View {
    @Binding var isSearchPresented: Bool
    @Binding var searchText: String
    
    let textColor: Color
    let magnifierColor: Color
    
    let shouldHandleTextInput: Bool
    let fiterAction: (DisplayOrderType) -> Void
    let placeholderColor: Color = .searchBarPlaceholder
    
    var body: some View {
        
        HStack {
            Button {
                isSearchPresented = true
            } label: {
                Image(.searchWhite)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.trailing,10)
                    .foregroundStyle(magnifierColor)
            }
            
            Rectangle()
                .frame(width: 1, height: 20)
                .foregroundStyle(placeholderColor)
            if shouldHandleTextInput {
                TextField("", text: $searchText)
                    .airbnbCerealFont( AirbnbCerealFont.book, size: 18)
                    .tint(textColor)
                    .foregroundStyle(textColor)
                    .placeholder(when: searchText.isEmpty) {
                        Text("Search...").foregroundColor(placeholderColor)
                    }
            } else {
                TextField("", text: .constant(""))
                    .airbnbCerealFont( AirbnbCerealFont.book, size: 18)
                    .tint(textColor)
                    .foregroundStyle(textColor)
                    .placeholder(when: searchText.isEmpty) {
                        Text("Search...").foregroundColor(placeholderColor)
                    }
                    .disabled(true)
                    .onTapGesture {
                        isSearchPresented = true
                    }
                
                
            }
            FiltersButtonView(filterAction: fiterAction)
        }
        
    }
}

#Preview {
    SearchBarView(
        isSearchPresented: .constant(false),
        searchText: .constant(""),
        textColor: .white,
        magnifierColor: .green,
        shouldHandleTextInput: true,
    fiterAction: { _ in }
        )
}
