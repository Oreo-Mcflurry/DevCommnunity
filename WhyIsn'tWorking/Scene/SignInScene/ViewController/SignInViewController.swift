//
//  SignInVIewController.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/11/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

import Alamofire

final class SignInViewController: BaseViewController {

	private let signInView = SignInView()
	private let signInViewModel = SignInViewModel()
	private let disposeBag = DisposeBag()

	override func loadView() {
		self.view = signInView
	}

	override func viewDidLoad() {
		super.viewDidLoad()

//		let loginModel = LoginRequestModel(email: "yuiop10239@naver.com", password: "123124")
//		RequestManager().requestLogin(loginModel)
//			.bind(with: self) { owner, value in
//				print(value)
//			}.disposed(by: disposeBag)
	}

	override func configureBinding() {
		let input = SignInViewModel.Input(inputEmailText: signInView.emailTextField.rx.text,
													 inputPasswordText: signInView.passwordTextField.rx.text,
													 inputTapLoginButton: signInView.loginButton.rx.tap,
													 inputTapSignupButton: signInView.signUpButton.rx.tap)

		let output = signInViewModel.transform(input: input)

		output.outputBackButton
			.drive(signInView.loginButton.rx.backgroundColor)
			.disposed(by: disposeBag)

		output.outputIsEnabled
			.drive(signInView.loginButton.rx.isEnabled)
			.disposed(by: disposeBag)

		output.outputTapSignupButton
			.drive(with: self) { owner, _ in
				owner.navigationController?.pushViewController(SignUpViewController(), animated: true)
			}.disposed(by: disposeBag)

		output.outputTapLoginButton
			.drive(with: self) { owner, _ in
				print("123123123")
			}.disposed(by: disposeBag)
	}
}
