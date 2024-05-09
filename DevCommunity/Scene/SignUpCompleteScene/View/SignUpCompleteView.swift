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
	let nextButton = UIButton()


	override func configureHierarchy() {
		[signUpLabelsView, nextButton].forEach { addSubview($0) }
	}

	override func configureLayout() {
		signUpLabelsView.snp.makeConstraints {
			$0.top.equalTo(self.safeAreaLayoutGuide)
			$0.horizontalEdges.equalTo(self).inset(20)
		}

		nextButton.snp.makeConstraints {
			$0.bottom.horizontalEdges.equalTo(self).inset(20)
			$0.height.equalTo(50)
		}
	}

	override func configureView() {
		signUpLabelsView.mainLabel.text = "회원가입 중 입니다."
		signUpLabelsView.subLabel.text = "조금만 기다려주세요."

		nextButton.isEnabled = false
		nextButton.setTitle("다음", for: .normal)
		nextButton.setTitleColor(.white, for: .normal)
		nextButton.backgroundColor = .lightGray
		nextButton.layer.cornerRadius = 20
	}

	func configureUI(_ error: BaseRequestManager.RequestError? = nil) {
		if error != nil {
//			let main = (error == .duplication) ? "이미 가입이 되어있습니다" : "알 수 없는 오류가 발생하였습니다"
//			let sub = (error == .duplication) ? "돌아가서 로그인을 시도해주세요." : "다음에 다시 시도해주세요."

			signUpLabelsView.mainLabel.text = "이미 가입이 되어있습니다"
			signUpLabelsView.subLabel.text = "돌아가서 로그인을 시도해주세요."
		} else {
			signUpLabelsView.mainLabel.text = "회원가입에 성공하였습니다."
			signUpLabelsView.subLabel.text = "\(UserDefaults.standard[.userNickname])님 환영합니다!"
		}

		nextButton.isEnabled = true
		nextButton.backgroundColor = .accent
	}
}
