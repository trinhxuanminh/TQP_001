//
//  SeasonsCoordinator.swift
//  Miramax Fillms
//
//  Created by Thanh Quang on 22/09/2022.
//

import XCoordinator
import Domain

enum SeasonsRoute: Route {
    case initial(seasons: [Season])
    case pop
    case seasonDetail(seasonNumber: Int)
}

class SeasonsCoordinator: NavigationCoordinator<SeasonsRoute> {
    
    private let appDIContainer: AppDIContainer
    private let tvShowId: Int
    private let tvShowViewModel: EntertainmentViewModel
    
    public override var viewController: UIViewController! {
        return autoreleaseController
    }
    
    private weak var autoreleaseController: UIViewController?
    
    init(appDIContainer: AppDIContainer, rootViewController: UINavigationController, tvShowViewModel: EntertainmentViewModel, seasons: [Season]) {
        self.appDIContainer = appDIContainer
        self.tvShowId = tvShowViewModel.id
        self.tvShowViewModel = tvShowViewModel
        super.init(rootViewController: rootViewController, initialRoute: nil)
        trigger(.initial(seasons: seasons))
    }
    
    override func prepareTransition(for route: SeasonsRoute) -> NavigationTransition {
        switch route {
        case .initial(seasons: let seasons):
            let vc = SeasonsViewController()
            vc.viewModel = SeasonsViewModel(repositoryProvider: appDIContainer.resolve(), router: unownedRouter, seasons: seasons)
            autoreleaseController = vc
            return .push(vc)
        case .pop:
            return .pop()
        case .seasonDetail(seasonNumber: let seasonNumber):
          addChild(SeasonDetailsCoordinator(appDIContainer: appDIContainer, rootViewController: rootViewController, tvShowViewModel: tvShowViewModel, seasonNumber: seasonNumber))
            return .none()
        }
    }
}
