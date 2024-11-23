//
//  DI.swift
//  EventHub
//
//  Created by Руслан on 18.11.2024.
//

import Swinject
import SwiftUI

class ServicesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(EventAPIService.self) { _ in
            EventAPIService()
        }.inObjectScope(.container)
    }
}

class ActionsAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(ExploreActions.self) { _ in
            return ExploreActions(
                showDetail: { eventID in
                    let coordinator = container.resolve(LaunchCoordinator.self)!
                    coordinator.showEventDetail(eventID: eventID)
                },
                closed: {
                    let router = container.resolve(Router.self)!
                    router.dismiss(animated: true)
                }
            )
        }.inObjectScope(.transient)
    }
}

//Регистрация контейнера
class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(UINavigationController.self) { _ in
            UINavigationController()
        }.inObjectScope(.container)
        
        container.register(NavigationRouter.self) { _ in
            NavigationRouter()
        }.inObjectScope(.container)
        
        container.register(Router.self) { resolver in
            let navigationController = resolver.resolve(UINavigationController.self)!
               return Router(rootController: navigationController)
        }.inObjectScope(.container)
        
        container.register(LaunchCoordinator.self) { resolver in
            let router = resolver.resolve(Router.self)!
            return LaunchCoordinator(router: router)
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

        container.register(DetailViewModel.self) { (resolver, eventID: Int, actions: DetailActions) in
            let apiService = resolver.resolve(EventAPIService.self)!
            return DetailViewModel(eventID: eventID, eventService: apiService)
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
        
        container.register(EventHubContentView.self) { (resolver, actions: TabBarActions) in
            EventHubContentView(container: resolver as! Container)
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
        

        container.register(DetailView.self) { (resolver, eventID: Int, actions: DetailActions) in
            let viewModel = resolver.resolve(DetailViewModel.self, arguments: eventID, actions)!
            return DetailView(model: viewModel)
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
                ViewAssembly(),
                ServicesAssembly(),
                ActionsAssembly()
            ],
            container: container
        )
    }
}
