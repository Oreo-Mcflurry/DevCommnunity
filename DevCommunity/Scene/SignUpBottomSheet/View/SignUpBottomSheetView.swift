//
//  SignUpBottomSheetView.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/13/24.
//

import UIKit
import SnapKit

final class SignUpBottomSheetView: BaseUIView {
	let termsOfServiceCheck = CheckBoxView()
	let privacyCheck = CheckBoxView()
	let nextButton = UIButton()

	override func configureHierarchy() {
		[termsOfServiceCheck, privacyCheck, nextButton].forEach { addSubview($0) }
	}

	override func configureLayout() {
		termsOfServiceCheck.snp.makeConstraints {
			$0.top.horizontalEdges.equalTo(self).offset(20)
		}

		privacyCheck.snp.makeConstraints {
			$0.top.equalTo(termsOfServiceCheck.snp.bottom).offset(20)
			$0.horizontalEdges.equalTo(self).inset(20)
		}

		nextButton.snp.makeConstraints {
			$0.top.equalTo(privacyCheck.snp.bottom).offset(20)
			$0.horizontalEdges.equalTo(self).inset(20)
			$0.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
		}
	}

	override func configureView() {
		nextButton.isEnabled = false
		nextButton.setTitle("확인", for: .normal)
		nextButton.setTitleColor(.white, for: .normal)
		nextButton.backgroundColor = .lightGray
		nextButton.layer.cornerRadius = 20

		termsOfServiceCheck.label.text = "이용 약관 동의 (필수)"
		privacyCheck.label.text = "개인정보 수집 및 이용 동의 (필수)"
	}
}
