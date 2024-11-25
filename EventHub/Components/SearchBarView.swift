//
//  SearchBarView.swift
//  EventHub
//
//  Created by Marat Fakhrizhanov on 20.11.2024.
//

import SwiftUI

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
                .foregroundStyle(.appPurple)
            
            TextField("Search...", text: $searchString)
                .onChange(of: searchString) { newValue in
                    searchText = newValue
                } // Если обновлять поиск после каждой введенной буквы
            
            FiltersButtonView(filterAction: fiterAction)
        }
//        .background(Color.appBlue) // for preview
        
    }
}

//#Preview {
//    SearchBarView(action: {  }, magnifierColor: .white)
//}
