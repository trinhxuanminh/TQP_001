//
//  TaskLoadingView.swift
//  ChatGPT_MinhTX
//
//  Created by Trịnh Xuân Minh on 23/04/2023.
//

import UIKit
import NVActivityIndicatorView
import SnapKit

class TaskLoadingView: UIView {
  private lazy var loadingView: NVActivityIndicatorView = {
    let loadingView = NVActivityIndicatorView(frame: .zero)
    loadingView.type = .ballSpinFadeLoader
    loadingView.padding = 30.0
    return loadingView
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    addComponents()
    setConstraints()
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    setColor()
    loadingView.startAnimating()
  }
  
  func addComponents() {
    addSubview(loadingView)
  }
  
  func setConstraints() {
    loadingView.snp.makeConstraints { make in
      make.width.height.equalTo(20.0)
      make.center.equalToSuperview()
    }
  }
  
  func setColor() {
    loadingView.color = UIColor.white
    setGradientBackground()
  }
  
  private func setGradientBackground() {
    let gradientView = GradientView()
    gradientView.translatesAutoresizingMaskIntoConstraints = false
    gradientView.startColor = AppColors.colorPrimary
    gradientView.endColor = AppColors.colorSecondary
    view.insertSubview(gradientView, at: 0)
    gradientView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.bottom.equalToSuperview()
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
    }
  }
}
