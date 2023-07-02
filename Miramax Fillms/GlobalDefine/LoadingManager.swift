//
//  LoadingManager.swift
//  Miramax Fillms
//
//  Created by Trịnh Xuân Minh on 29/06/2023.
//

import UIKit

class LoadingManager {
  static let shared = LoadingManager()
  
  private var loadingView: UIView?
  
  func show() {
    guard let topVC = UIApplication.topViewController() else {
      return
    }
    let loadingView = TaskLoadingView.initFromNib()
    loadingView.frame = topVC.view.frame
    self.loadingView = loadingView
    topVC.view.addSubview(loadingView)
  }
  
  func hide() {
    loadingView?.removeFromSuperview()
  }
}
