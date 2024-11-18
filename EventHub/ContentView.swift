//
//  ContentView.swift
//  EventHub
//
//  Created by Денис Гиндулин on 16.11.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var password = ""
    var body: some View {
        VStack {
            AuthTextField(textFieldText: $password, placeholder: "Password", imageName: "person", isSecure: true)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
