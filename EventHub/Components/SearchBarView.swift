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
    
    
    @Binding var searchText: String
    @State private var searchString = ""
    
   
    let fiterAction: (DisplayOrderType) -> Void
    let magnifierColor: Color
    
    
    
    var body: some View {
        
        HStack {
            Button {
                searchText = String(searchString)
            } label: {
                Image(.searchWhite)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.trailing,10)
                    .foregroundStyle(magnifierColor)
            }
            
            Rectangle()
                .frame(width: 1, height: 20)
                .foregroundStyle(.searchBarPlaceholder)
            
            TextField("", text: $searchString)
                .airbnbCerealFont( AirbnbCerealFont.book, size: 18)
                .tint(.white)
                .foregroundStyle(.white)
                .placeholder(when: searchString.isEmpty) {
                    Text("Search...").foregroundColor(.searchBarPlaceholder)
               }
                .onChange(of: searchString) { newValue in
                    searchText = newValue
                } // Если обновлять поиск после каждой введенной буквы
            
            FiltersButtonView(filterAction: fiterAction)
        }
        
    }
}

//#Preview {
//    SearchBarView(action: {  }, magnifierColor: .white)
//}
