//
//  BaseUIView.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit

class BaseUIView: UIView {

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
