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
	}

	override func configureBinding() {

		let inputTapLoginButton = PublishSubject<(String?, String?)>()

		signInView.loginButton.rx.tap
			.withLatestFrom(signInView.emailTextField.rx.text)
			.withLatestFrom(signInView.passwordTextField.rx.text) { ($0, $1)}
			.bind(to: inputTapLoginButton)
			.disposed(by: disposeBag)

			


		let input = SignInViewModel.Input(inputEmailText: signInView.emailTextField.rx.text,
													 inputPasswordText: signInView.passwordTextField.rx.text,
													 inputTapLoginButton: inputTapLoginButton,
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
			.drive(with: self) { owner, value in
				owner.view.endEditing(true)
				if value {
					owner.view.window?.rootViewController = TabbarViewController()
				} else {
					owner.showToast(.loginError)
				}
			}.disposed(by: disposeBag)
	}
}
