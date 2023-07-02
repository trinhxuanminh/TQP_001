//
//  WishlistCoordinator.swift
//  Miramax Fillms
//
//  Created by Thanh Quang on 08/10/2022.
//

import XCoordinator
import Domain

enum WishlistRoute: Route {
    case initial
    case search
    case entertainmentDetail(entertainmentViewModel: EntertainmentViewModel, entertainmentType: EntertainmentType)
    case personDetail(personId: Int)
}

class WishlistCoordinator: NavigationCoordinator<WishlistRoute> {
    
    private let appDIContainer: AppDIContainer

    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
        super.init(initialRoute: .initial)
        
        rootViewController.setNavigationBarHidden(true, animated: false)
    }
    
    override func prepareTransition(for route: WishlistRoute) -> NavigationTransition {
        switch route {
        case .initial:
            let vc = WishlistViewController()
            vc.viewModel = WishlistViewModel(repositoryProvider: appDIContainer.resolve(), router: unownedRouter)
            return .push(vc)
        case .search:
            let searchCoordinator = SearchCoordinator(appDIContainer: appDIContainer)
            return .presentFullScreen(searchCoordinator, animation: .fade)
        case .entertainmentDetail(entertainmentViewModel: let entertainmentViewModel, entertainmentType: let entertainmentType):
            addChild(EntertainmentDetailsCoordinator(appDIContainer: appDIContainer, rootViewController: rootViewController, entertainmentViewModel: entertainmentViewModel, entertainmentType: entertainmentType))
            return .none()
        case .personDetail(personId: let personId):
            addChild(PersonDetailsCoordinator(appDIContainer: appDIContainer, rootViewController: rootViewController, personId: personId))
            return .none()
        }
    }
}
