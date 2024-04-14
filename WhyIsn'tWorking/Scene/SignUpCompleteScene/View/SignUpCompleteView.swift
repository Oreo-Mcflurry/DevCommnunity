//
//  SignUpCompleteView.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/13/24.
//

import UIKit
import SnapKit
import SwiftUI

final class SignUpCompleteView: BaseUIView {
	private let signUpLabelsView = SignUpLabelsView()
	private var progressView = UIView()

	override func configureHierarchy() {
		[signUpLabelsView].forEach { addSubview($0) }
	}

	override func configureLayout() {
		signUpLabelsView.snp.makeConstraints {
			$0.top.equalTo(self.safeAreaLayoutGuide)
			$0.horizontalEdges.equalTo(self).inset(20)
		}
	}

	override func configureView() {
		signUpLabelsView.mainLabel.text = "회원가입 중 입니다."
		signUpLabelsView.subLabel.text = "조금만 기다려주세요."
	}
}
