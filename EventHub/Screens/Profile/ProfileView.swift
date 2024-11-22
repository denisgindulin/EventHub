//
//  ProfileView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var model: ProfileViewModel
    var body: some View {
        Text("C")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EventHubApp.dependencyProvider.assembler.resolver.resolve(ProfileView.self)!
    }
}
