//
//  SearchBarViewForMap 2.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 02.12.2024.
//


import SwiftUI

struct SearchBarForMap: View {
    @Binding var searchText: String
    
    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .frame(height: 51)
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(12)
            .shadow(color: Color(red: 0.83, green: 0.82, blue: 0.85).opacity(0.5), radius: 30, x: 0, y: 40)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.93, green: 0.93, blue: 0.93), lineWidth: 1)
            )
            .overlay(
                HStack {
                    TextField("Find for food or restaurant...", text: $searchText)
                        .foregroundColor(.geolocationText)
                        .font(.system(size: 16))
                        .textFieldStyle(PlainTextFieldStyle())
                        .disableAutocorrection(true)
                        .submitLabel(.done)
                        .onSubmit {
                            // action
                            print("Поиск: \(searchText)")
                        }
                }
                    .padding(.horizontal, 16)
            )
    }
}

#Preview {
    SearchBarForMap(searchText: .constant(" "))
}
