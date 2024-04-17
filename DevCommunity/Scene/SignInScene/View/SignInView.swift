//
//  SignInView.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/11/24.
//

import UIKit
import SnapKit

final class SignInView: BaseUIView {
	private let signUpLabelsView = SignUpLabelsView()
	let emailTextField = SignUpTextField()
	let passwordTextField = SignUpTextField()
	let loginButton = UIButton()
	let signUpButton = UIButton()

	override func configureHierarchy() {
		[signUpLabelsView, emailTextField, passwordTextField, loginButton, signUpButton].forEach { addSubview($0) }
	}

	override func configureLayout() {
		signUpLabelsView.snp.makeConstraints {
			$0.top.equalTo(self.safeAreaLayoutGuide)
			$0.horizontalEdges.equalTo(self).inset(20)
		}

		emailTextField.snp.makeConstraints {
			$0.top.equalTo(signUpLabelsView.snp.bottom).offset(50)
			$0.horizontalEdges.equalTo(self).inset(20)
			$0.height.equalTo(60)
		}

		passwordTextField.snp.makeConstraints {
			$0.top.equalTo(emailTextField.snp.bottom).offset(30)
			$0.horizontalEdges.equalTo(self).inset(20)
			$0.height.equalTo(60)
		}

		loginButton.snp.makeConstraints {
			$0.top.equalTo(passwordTextField.snp.bottom).offset(30)
			$0.horizontalEdges.equalTo(self).inset(20)
			$0.height.equalTo(45)
		}

		signUpButton.snp.makeConstraints {
			$0.top.equalTo(loginButton.snp.bottom).offset(30)
			$0.horizontalEdges.equalTo(self).inset(20)
		}
	}

	override func configureView() {
		signUpLabelsView.mainLabel.text = "품격있는 개발자들의\n커뮤니티"
		signUpLabelsView.subLabel.text = "로그인 또는 회원가입을 해주세요."

		emailTextField.placeholder = "이메일"
		passwordTextField.placeholder = "비밀번호"

		passwordTextField.isSecureTextEntry = true

		loginButton.isEnabled = false
		loginButton.setTitle("로그인", for: .normal)
		loginButton.setTitleColor(.white, for: .normal)
		loginButton.backgroundColor = .lightGray
		loginButton.layer.cornerRadius = 20

		signUpButton.setTitle("계정이 없으신가요?", for: .normal)
		signUpButton.setTitleColor(.black, for: .normal)
	}
}
