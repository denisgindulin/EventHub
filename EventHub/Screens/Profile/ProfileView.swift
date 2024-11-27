//
//  ProfileView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    
    init(router: StartRouter) {
        self._viewModel = StateObject(
            wrappedValue: ProfileViewModel(router: router)
        )
    }
    
    var body: some View {
        Text("C")
    }
}


