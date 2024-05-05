//
//  BaseStepperView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/5/24.
//

import UIKit
import SnapKit

final class BaseStepperView: BaseUIView {
	let mainLabel = UILabel()
	let stepper = UIStepper()

	override func configureHierarchy() {
		[mainLabel, stepper].forEach { addSubview($0) }
	}

	override func configureLayout() {
		mainLabel.snp.makeConstraints {
			$0.verticalEdges.equalTo(self).inset(10)
			$0.leading.equalTo(self)
		}

		stepper.snp.makeConstraints {
			$0.verticalEdges.equalTo(self).inset(10)
			$0.trailing.equalTo(self)
			$0.leading.greaterThanOrEqualTo(mainLabel)
		}
	}

	override func configureView() {
		mainLabel.text = "Test"
	}

	func configureUI(_ text: String, _ value: Int) {
		mainLabel.text = "\(text) \(value)명"
	}
}
