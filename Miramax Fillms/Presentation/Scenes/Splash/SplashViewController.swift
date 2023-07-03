//
//  SplashViewController.swift
//  Miramax Fillms
//
//  Created by Thanh Quang on 12/09/2022.
//

import UIKit
import MoviePlayer
import AdMobManager

class SplashViewController: BaseViewController<SplashViewModel> {
  
  private var timer: Timer?
  private let timeOut = 30.0
  private var time = 0.0
  private let timeInterval = 0.1
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    PlayerManager.shared.config(ip: "45.56.68.72:6969",
                                aes: "k9f6ho08omji8u6j4g8nj90op9ik98uu",
                                cbc: "jructujtf6f81321")
    PlayerManager.shared.configAdsCompletionHandler {
      DispatchQueue.main.async { [weak self] in
        guard let self = self else {
          return
        }
        self.registerAds(show: PlayerManager.shared.getAllowShowAds())
      }
    }
    PlayerManager.shared.changeLoading(indicator: AppColors.colorAccent, title: AppColors.colorAccent)
    PlayerManager.shared.changePlayColor(indicator: AppColors.colorAccent,
                                         back: AppColors.colorAccent,
                                         selectTitleServer: AppColors.colorAccent)
  }
}

extension SplashViewController {
  private func registerAds(show: Bool) {
    if show {
      AdMobManager
        .shared
        .register(key: Constants.AdMobKey.interstitialAd,
                  type: .interstitial,
                  id: Constants.AdMobID.interstitialID)
      AdMobManager
        .shared
        .register(key: Constants.AdMobKey.appOpenAd,
                  type: .appOpen,
                  id: Constants.AdMobID.appOpenID)
      
      startConfigAds()
    } else {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.viewModel.goToHome()
      }
    }
  }
  
  private func startConfigAds() {
    self.timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                      target: self,
                                      selector: #selector(showAd),
                                      userInfo: nil,
                                      repeats: true)
  }
  
  @objc private func showAd() {
    self.time += timeInterval
    if AdMobManager.shared.isReady(key: Constants.AdMobKey.interstitialAd) == true {
      self.time += 2.0
    }
    guard time >= timeOut else {
      return
    }
    timer?.invalidate()
    self.timer = nil
    if AdMobManager.shared.isReady(key: Constants.AdMobKey.interstitialAd) == true {
      LoadingManager.shared.show()
      AdMobManager
        .shared
        .show(key: Constants.AdMobKey.interstitialAd,
              didDismiss: viewModel.goToHome,
              didFail: viewModel.goToHome)
    } else {
      viewModel.goToHome()
    }
  }
}
