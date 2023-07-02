//
//  Global.swift
//  Miramax Fillms
//
//  Created by Trịnh Xuân Minh on 29/06/2023.
//

import Foundation
import AdMobManager

class Global {
  static let shared = Global()
  
  private(set) var isSplashAnimation = true
  private var numberClickToItem = 0
  
  func stopSplashAnimation() {
    self.isSplashAnimation = false
  }
  
  func clickToItem(completed: (() -> Void)?) {
    self.numberClickToItem += 1
    guard numberClickToItem % 2 == 1 else {
      completed?()
      return
    }
    guard AdMobManager.shared.isReady(key: Constants.AdMobKey.interstitialAd) == true else {
      completed?()
      return
    }
    AdMobManager.shared.show(key: Constants.AdMobKey.interstitialAd, didDismiss: completed, didFail: completed)
  }
}
