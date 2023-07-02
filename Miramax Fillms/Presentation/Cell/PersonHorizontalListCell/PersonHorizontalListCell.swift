//
//  PersonHorizontalListCell.swift
//  Miramax Fillms
//
//  Created by Thanh Quang on 18/09/2022.
//

import UIKit
import SnapKit
import SwifterSwift
import Domain

class PersonHorizontalListCell: UICollectionViewCell {
    
    // MARK: - Views
    
    private var sectionHeaderView: SectionHeaderView!
    private var personCollectionView: UICollectionView!
    private var loadingIndicatorView: UIActivityIndicatorView!
    private var btnRetry: PrimaryButton!
    
    // MARK: - Properties
    
    public weak var delegate: PersonHorizontalListCellDelegate?
    private var indexPath: IndexPath?
    private var personItems: [PersonViewModel] = []
    
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
        personCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        personCollectionView.translatesAutoresizingMaskIntoConstraints = false
        personCollectionView.backgroundColor = .clear
        personCollectionView.register(cellWithClass: PersonHorizontalCell.self)
        personCollectionView.dataSource = self
        personCollectionView.delegate = self
        personCollectionView.showsHorizontalScrollIndicator = false
        
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
        
        contentView.addSubview(personCollectionView)
        personCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionHeaderView.snp.bottom).offset(12.0)
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        contentView.addSubview(loadingIndicatorView)
        loadingIndicatorView.snp.makeConstraints { make in
            make.center.equalTo(personCollectionView.snp.center)
        }
        
        contentView.addSubview(btnRetry)
        btnRetry.snp.makeConstraints { make in
            make.center.equalTo(personCollectionView.snp.center)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(
        _ items: [PersonViewModel],
        indexPath: IndexPath,
        headerTitle: String,
        headerActionButtonTitle: String,
        showActionButton: Bool
    ) {
        self.indexPath = indexPath
        
        sectionHeaderView.title = headerTitle
        sectionHeaderView.actionButtonTittle = headerActionButtonTitle
        
        loadingIndicatorView.stopAnimating()
        personCollectionView.isHidden = false
        btnRetry.isHidden = true
        // set data
        personItems = items
        personCollectionView.reloadData()
        sectionHeaderView.showActionButton = showActionButton
    }
    
    @objc private func btnRetryTapped() {
        loadingIndicatorView.startAnimating()
        personCollectionView.isHidden = true
        btnRetry.isHidden = true
        guard let indexPath = indexPath else { return }
        delegate?.personHorizontalList(onRetryButtonTapped: indexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension PersonHorizontalListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = personItems[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withClass: PersonHorizontalCell.self, for: indexPath)
        cell.bind(item)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension PersonHorizontalListCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = personItems[indexPath.row]
        delegate?.personHorizontalList(onItemTapped: item)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PersonHorizontalListCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemHeight = collectionView.frame.height
        let itemWidth = itemHeight * DimensionConstants.personHorizontalCellRatio
        return .init(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 16.0, bottom: 0.0, right: 16.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return DimensionConstants.personHorizontalCellSpacing
    }
}

// MARK: - SectionHeaderViewDelegate

extension PersonHorizontalListCell: SectionHeaderViewDelegate {
    func sectionHeaderView(onActionButtonTapped button: UIButton) {
        guard let indexPath = indexPath else { return }
        delegate?.personHorizontalList(onActionButtonTapped: indexPath)
    }
}
