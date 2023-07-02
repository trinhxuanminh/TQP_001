//
//  HomeCoordinator.swift
//  Miramax Fillms
//
//  Created by Thanh Quang on 12/09/2022.
//

import XCoordinator

enum HomeTabRoute: Route {
    case movie
    case tvShow
    case geners
    case wishlist
    case setting
}

class HomeCoordinator: TabBarCoordinator<HomeTabRoute> {
    private let movieRoute: StrongRouter<MovieRoute>
    private let tvShowRoute: StrongRouter<TVShowRoute>
    private let genresRoute: StrongRouter<GenresRoute>
    private let wishlistRoute: StrongRouter<WishlistRoute>
    private let settingRoute: StrongRouter<SettingRoute>
    
    init(appDIContainer: AppDIContainer) {
        let movieCoordinator = MovieCoordinator(appDIContainer: appDIContainer)
        movieCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "movie".localized, image: UIImage(named: "ic_tab_home"), tag: 0)
        movieRoute = movieCoordinator.strongRouter

        let tvShowCoordinator = TVShowCoordinator(appDIContainer: appDIContainer)
        tvShowCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "tvshow".localized, image: UIImage(named: "ic_tab_tv"), tag: 1)
        tvShowRoute = tvShowCoordinator.strongRouter
        
        let genresCoordinator = GenresCoordinator(appDIContainer: appDIContainer)
        genresCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "genres".localized, image: UIImage(named: "ic_tab_genres"), tag: 2)
        genresRoute = genresCoordinator.strongRouter
        
        let wishlistCoordinator = WishlistCoordinator(appDIContainer: appDIContainer)
        wishlistCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "wishlist".localized, image: UIImage(named: "ic_tab_bookmark"), tag: 3)
        wishlistRoute = wishlistCoordinator.strongRouter
        
        let settingCoordinator = SettingCoordinator(appDIContainer: appDIContainer)
        settingCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "setting".localized, image: UIImage(named: "ic_tab_setting"), tag: 4)
        settingRoute = settingCoordinator.strongRouter
        
        super.init(rootViewController: HomeTabBarController(), tabs: [movieRoute, tvShowRoute, genresRoute, wishlistRoute, settingRoute], select: movieRoute)
    }
    
    override func prepareTransition(for route: HomeTabRoute) -> TabBarTransition {
        switch route {
        case .movie:
            return .select(movieRoute)
        case .tvShow:
            return .select(tvShowRoute)
        case .geners:
            return .select(genresRoute)
        case .wishlist:
            return .select(wishlistRoute)
        case .setting:
            return .select(settingRoute)
        }
    }
}
