//
//  SignUpLabelsView.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/14/24.
//

import UIKit
import SnapKit

final class SignUpLabelsView: BaseUIView {
	let mainLabel = UILabel()
	let subLabel = UILabel()

	override func configureHierarchy() {
		[mainLabel, subLabel].forEach { addSubview($0) }
	}

	override func configureLayout() {
		mainLabel.snp.makeConstraints {
			$0.top.equalTo(self.safeAreaLayoutGuide).inset(20)
			$0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
		}

		subLabel.snp.makeConstraints {
			$0.top.equalTo(mainLabel.snp.bottom).offset(20)
			$0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
			$0.bottom.equalTo(self)
		}
	}

	override func configureView() {
		mainLabel.numberOfLines = 2
		mainLabel.font = .boldSystemFont(ofSize: 30)

		subLabel.numberOfLines = 2
		subLabel.textColor = .gray
	}
}
