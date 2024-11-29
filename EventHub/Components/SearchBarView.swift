//
//  SearchBarView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

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
    @State private var searchString = ""
    
    let textColor: Color
    let placeholderColor: Color
    
    let fiterAction: (DisplayOrderType) -> Void
    let magnifierColor: Color
    
    let action: () -> Void
    
    
    var body: some View {
        
        HStack {
            Button {
                searchText = String(searchString)
                action()
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
            
            TextField("", text: $searchString)
                .airbnbCerealFont( AirbnbCerealFont.book, size: 18)
                .tint(textColor)
                .foregroundStyle(textColor)
                .placeholder(when: searchString.isEmpty) {
                    Text("Search...").foregroundColor(placeholderColor)
               }
                .onChange(of: searchString) { newValue in
                    searchText = newValue
                } // Если обновлять поиск после каждой введенной буквы
            
            FiltersButtonView(filterAction: fiterAction)
        }
        
    }
}

#Preview {
    SearchBarView(isSearchPresented: .constant(false), searchText: .constant(""), textColor: .white, placeholderColor: .searchBarPlaceholder, fiterAction: {_ in }, magnifierColor: .white, action: {})
}
