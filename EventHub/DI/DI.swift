//
//  DI.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import Swinject
import SwiftUI


//Регистрация контейнера
class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(NavigationRouter.self) { _ in
            NavigationRouter()
        }.inObjectScope(.container)
        
        container.register(EventAPIService.self) { _ in
            EventAPIService() 
        }.inObjectScope(.container)
        
        container.register(OnboardingViewModel.self) { (resolver, actions: OnboardingActions) in
            OnboardingViewModel(actions: actions)
        }.inObjectScope(.transient)
        
        container.register(SignUpViewModel.self) { (resolver, actions: SignUpActions) in
            SignUpViewModel(actions: actions)
        }.inObjectScope(.transient)
        
        container.register(TabBarViewModel.self) { (resolver, actions: TabBarActions) in
            TabBarViewModel(actions: actions)
        }.inObjectScope(.transient)
        
        container.register(SignInViewModel.self) { (resolver, actions: SignInActions) in
            SignInViewModel(actions: actions)
        }.inObjectScope(.transient)
        
        container.register(ExploreViewModel.self) { (resolver, actions: ExploreActions) in
            let apiService = resolver.resolve(EventAPIService.self)!
            return ExploreViewModel(actions: actions, apiService: apiService)
        }.inObjectScope(.transient)
        
        container.register(EventsViewModel.self) { (resolver, actions: EventsActions) in
            EventsViewModel(actions: actions)
        }.inObjectScope(.transient)
        
        container.register(ProfileViewModel.self) { (resolver, actions: ProfileActions) in
            ProfileViewModel(actions: actions)
        }.inObjectScope(.transient)
        
        container.register(MapViewModel.self) { (resolver, actions: MapViewActions) in
            MapViewModel(actions: actions)
        }.inObjectScope(.transient)
        
        container.register(BookmarksViewModel.self) { (resolver, actions: BookmarksViewActions) in
            BookmarksViewModel(actions: actions)
        }.inObjectScope(.transient)
    }
}
    

class ViewAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(MaintView.self) { (resolver, actions: TabBarActions) in
            MaintView(container: resolver as! Container)
        }
        container.register(OnboardingView.self) { (resolver, actions: OnboardingActions) in
            OnboardingView(model: resolver.resolve(OnboardingViewModel.self, argument: actions)!)
        }.inObjectScope(.transient)
        
        container.register(SignInView.self) { (resolver, actions: SignInActions) in
            SignInView(model: resolver.resolve(SignInViewModel.self, argument: actions)!)
        }.inObjectScope(.transient)
        
        container.register(SignUpView.self) { (resolver, actions: SignUpActions) in
            SignUpView(model: resolver.resolve(SignUpViewModel.self, argument: actions)!)
        }.inObjectScope(.transient)
        
        container.register(SignInView.self) { (resolver, actions: SignInActions) in
            SignInView(model: resolver.resolve(SignInViewModel.self, argument: actions)!)
        }.inObjectScope(.transient)
        
        container.register(ExploreView.self) { (resolver, actions: ExploreActions) in
            ExploreView(model: resolver.resolve(ExploreViewModel.self, argument: actions)!)
        }.inObjectScope(.transient)
        
        container.register(EventsView.self) { (resolver, actions: EventsActions) in
            EventsView(model: resolver.resolve(EventsViewModel.self, argument: actions)!)
        }.inObjectScope(.transient)
        
        container.register(ProfileView.self) { (resolver, actions: ProfileActions) in
            ProfileView(model: resolver.resolve(ProfileViewModel.self, argument: actions)!)
        }.inObjectScope(.transient)
        
        container.register(MapView.self) { (resolver, actions: MapViewActions) in
            MapView(model: resolver.resolve(MapViewModel.self, argument: actions)!)
        }.inObjectScope(.transient)
        
        container.register(BookmarksView.self) { (resolver, actions: BookmarksViewActions) in
            BookmarksView(model: resolver.resolve(BookmarksViewModel.self, argument: actions)!)
        }.inObjectScope(.transient)
    }
    
}

class DependencyProvider {
    
    let container = Container()
    let assembler: Assembler
    
    init() {
        assembler = Assembler(
            [
                ViewModelAssembly(),
                ViewAssembly()
            ],
            container: container
        )
    }
}
