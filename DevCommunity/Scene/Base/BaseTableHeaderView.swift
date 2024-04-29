//
//  BaseTableHeaderView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/29/24.
//

import UIKit

class BaseTableHeaderView: UITableViewHeaderFooterView {
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		configureHierarchy()
		configureLayout()
		configureView()
	}

	required init?(coder: NSCoder) {
		fatalError()
	}

	func configureHierarchy() { }
	func configureLayout() { }
	func configureView() { }
}
