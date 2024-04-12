//
//  CollectionViewCell.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureHierarchy()
		configureLayout()
		configureView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configureHierarchy() { }
	func configureLayout() { }
	func configureView() { }
}
