//
//  BaseUIView.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit

class BaseUIView: UIView {

	let textFieldSize: CGFloat = 50
	let verticalPadding: CGFloat = 40
	let betweenPadding: CGFloat = 10
	let defaultPadding: CGFloat = 20

	override init(frame: CGRect) {
		super.init(frame: frame)
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
