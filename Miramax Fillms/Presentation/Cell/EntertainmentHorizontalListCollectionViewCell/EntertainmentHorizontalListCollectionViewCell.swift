//
//  EntertainmentHorizontalListCollectionViewCell.swift
//  Miramax Fillms
//
//  Created by Thanh Quang on 15/09/2022.
//

import UIKit
import SnapKit
import SwifterSwift
import Domain

class EntertainmentHorizontalListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Views
    
    private var sectionHeaderView: SectionHeaderView!
    private var collectionView: UICollectionView!
    private var loadingIndicatorView: UIActivityIndicatorView!
    private var btnRetry: PrimaryButton!
    
    // MARK: - Properties
    
    public weak var delegate: EntertainmentHorizontalListCollectionViewCellDelegate?
    
    private var items: [EntertainmentViewModel] = []
    private var indexPath: IndexPath?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        // section header view
        
        sectionHeaderView = SectionHeaderView()
        sectionHeaderView.translatesAutoresizingMaskIntoConstraints = false
        sectionHeaderView.delegate = self
        
        // collection view
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(cellWithClass: EntertainmentHorizontalCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        
        // loading indicator
        
        loadingIndicatorView = UIActivityIndicatorView(style: .white)
        loadingIndicatorView.hidesWhenStopped = true
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        // retry button
        
        btnRetry = PrimaryButton()
        btnRetry.titleText = "retry".localized
        btnRetry.addTarget(self, action: #selector(btnRetryTapped), for: .touchUpInside)
        
        // constraint layout
        
        contentView.addSubview(sectionHeaderView)
        sectionHeaderView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(24.0)
        }
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionHeaderView.snp.bottom).offset(12.0)
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        contentView.addSubview(loadingIndicatorView)
        loadingIndicatorView.snp.makeConstraints { make in
            make.center.equalTo(collectionView.snp.center)
        }
        
        contentView.addSubview(btnRetry)
        btnRetry.snp.makeConstraints { make in
            make.center.equalTo(collectionView.snp.center)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(
        _ items: [EntertainmentViewModel],
        indexPath: IndexPath,
        headerTitle: String,
        headerActionButtonTitle: String,
        showActionButton: Bool
    ) {
        self.items = items
        self.indexPath = indexPath
        
        sectionHeaderView.title = headerTitle
        sectionHeaderView.actionButtonTittle = headerActionButtonTitle
        sectionHeaderView.showActionButton = showActionButton
        
        loadingIndicatorView.stopAnimating()
        collectionView.isHidden = false
        btnRetry.isHidden = true
        
        collectionView.reloadData()
    }
    
    @objc private func btnRetryTapped() {
        loadingIndicatorView.startAnimating()
        collectionView.isHidden = true
        btnRetry.isHidden = true
        guard let indexPath = indexPath else { return }
        delegate?.entertainmentHorizontalList(onRetryButtonTapped: indexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension EntertainmentHorizontalListCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withClass: EntertainmentHorizontalCell.self, for: indexPath)
        cell.bind(item)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension EntertainmentHorizontalListCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        delegate?.entertainmentHorizontalList(onItemTapped: item)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension EntertainmentHorizontalListCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemHeight = collectionView.frame.height
        let itemWidth = itemHeight * DimensionConstants.entertainmentHorizontalCellRatio
        return .init(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 16.0, bottom: 0.0, right: 16.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return DimensionConstants.entertainmentHorizontalCellSpacing
    }
}

// MARK: - SectionHeaderViewDelegate

extension EntertainmentHorizontalListCollectionViewCell: SectionHeaderViewDelegate {
    func sectionHeaderView(onActionButtonTapped button: UIButton) {
        guard let indexPath = indexPath else { return }
        delegate?.entertainmentHorizontalList(onActionButtonTapped: indexPath)
    }
}
