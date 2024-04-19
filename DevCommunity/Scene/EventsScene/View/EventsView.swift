//
//  HomeVIew.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/15/24.
//

import UIKit
import SnapKit

final class EventsView: BaseUIView {

//	lazy var eventCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionView())
	let eventCollectionView = UITableView()
	let refreshControl = UIRefreshControl()

	override func configureHierarchy() {
		[eventCollectionView].forEach { addSubview($0) }
	}

	override func configureLayout() {
		eventCollectionView.snp.makeConstraints {
			$0.edges.equalTo(self)
		}
	}

	override func configureView() {
//		eventCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Test")
		eventCollectionView.register(UITableViewCell.self, forCellReuseIdentifier: "Test")
		eventCollectionView.refreshControl = refreshControl

	}

	private func setCollectionView() -> UICollectionViewLayout {
		let layout = UICollectionViewFlowLayout()
		let padding: CGFloat = 15
		let mainWidth = UIScreen.main.bounds.width
		layout.itemSize = CGSize(width: (mainWidth-15*3)/2, height: (mainWidth-15*3)/2)
		layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		layout.minimumLineSpacing = padding
		layout.minimumInteritemSpacing = padding
		return layout
	}
}
