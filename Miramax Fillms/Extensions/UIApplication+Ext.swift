//
//  UIApplication+Ext.swift
//  Miramax Fillms
//
//  Created by Trịnh Xuân Minh on 29/06/2023.
//

import UIKit

extension UIApplication {
  class func topViewController(viewController: UIViewController? = nil) -> UIViewController? {
    var viewController = viewController
    if viewController == nil {
      viewController = UIApplication.shared.windows.first?.rootViewController
    }
    if let navigationController = viewController as? UINavigationController {
      return topViewController(viewController: navigationController.visibleViewController)
    }
    if let tabBarController = viewController as? UINavigationController {
      return topViewController(viewController: tabBarController)
    }
    if let presented = viewController?.presentedViewController {
      return topViewController(viewController: presented)
    }
    return viewController
  }
}
