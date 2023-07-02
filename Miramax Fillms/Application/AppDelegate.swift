//
//  AppDelegate.swift
//  Miramax Fillms
//
//  Created by Thanh Quang on 05/09/2022.
//

import UIKit
import XCoordinator
import GoogleMobileAds
import AdMobManager

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  private lazy var mainWindow = UIWindow()
  
  private let appDIContainer = AppDIContainer.shared
  private var router: StrongRouter<AppRoute>!
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    GADMobileAds.sharedInstance().start(completionHandler: nil)
    if #available(iOS 13.0, *) {
      mainWindow.overrideUserInterfaceStyle = .light // force disable dark mode
    }
    
    router = AppCoordinator(appDIContainer: appDIContainer).strongRouter
    router.setRoot(for: mainWindow)
    
    return true
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    guard !Global.shared.isSplashAnimation else {
      return
    }
    if AdMobManager.shared.isReady(key: Constants.AdMobKey.appOpenAd) == true {
      AdMobManager
        .shared
        .show(key: Constants.AdMobKey.appOpenAd)
    }
  }
}
