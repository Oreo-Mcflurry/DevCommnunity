//
//  HomeVIew.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/15/24.
//

import UIKit
import SnapKit

final class HomeView: BaseUIView {
	let testLabel = UILabel()

	override func configureHierarchy() {
		[testLabel].forEach { addSubview($0) }
	}

	override func configureLayout() {
		testLabel.snp.makeConstraints {
			$0.center.equalTo(self)
			$0.height.equalTo(30)
		}
	}

	override func configureView() {
		testLabel.text = "Main"
	}
}
