//
//  HomeTabBarController.swift
//  Miramax Fillms
//
//  Created by Thanh Quang on 07/10/2022.
//

import UIKit

class HomeTabBarController: UITabBarController {
  private let indicator: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = AppColors.colorAccent
    view.frame.size = CGSize(width: 62, height: 2)
    view.layer.cornerRadius = 1
    view.isHidden = true
    return view
  }()
  
  private var currentSelectedItemIndex: Int!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    Global.shared.stopSplashAnimation()
    LoadingManager.shared.hide()
    configTabBar()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    moveIndicator(index: selectedIndex, animate: false)
    indicator.isHidden = false
  }
  
  private func configTabBar() {
    tabBar.isTranslucent = false
    tabBar.barTintColor = AppColors.colorTertiary
    tabBar.tintColor = .white
    tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.5)
    tabBar.backgroundColor = AppColors.colorTertiary
    tabBar.addSubview(indicator)
    delegate = self
  }
  
  private func moveIndicator(index: Int, animate: Bool) {
    let buttons = tabBar.subviews.filter { String(describing: $0).contains("Button") }
    
    guard index < buttons.count else { return }
    
    let selectedButton = buttons[index]
    
    let move: () -> Void = {
      let point = CGPoint(
        x: selectedButton.center.x,
        y: selectedButton.frame.minY
      )
      self.indicator.center = point
    }
    
    if animate {
      UIView.animate(
        withDuration: 0.25,
        delay: 0,
        options: .curveEaseInOut,
        animations: { move() }
      )
    } else {
      move()
    }
  }
}

// MARK: - UITabBarControllerDelegate

extension HomeTabBarController: UITabBarControllerDelegate {
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    guard
      let items = tabBar.items,
      let index = items.firstIndex(of: item)
    else {
      return
    }
    
    moveIndicator(index: index, animate: true)
  }
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    guard let currentTabBarIndex = viewControllers?.firstIndex(of: viewController),
          currentTabBarIndex == selectedIndex,
          selectedIndex == currentSelectedItemIndex else {
      currentSelectedItemIndex = selectedIndex
      return
    }
    guard let navigationController = viewController as? UINavigationController,
          let tabBarScrollable = navigationController.topViewController as? TabBarSelectable else { return }
    tabBarScrollable.handleTabBarSelection()
  }
}
