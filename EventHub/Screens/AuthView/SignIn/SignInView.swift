//
//  SignInView.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var model: SignInViewModel
    var body: some View {
        
        Button(action: {
            model.showMainView()},
               label: {
            Text("Next")
        })
        Button(action: {
            model.close()},
               label: {
            Text("Button")
        })
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        EventHubApp.dependencyProvider.assembler.resolver.resolve(SignInView.self)!
    }
}
