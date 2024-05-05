//
//  SignUpViewCompleteScene.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/13/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpViewCompleteViewController: BaseViewController {
	private let signUpCompleteView = SignUpCompleteView()
	var viewModel = SignUpViewCompleteViewModel()

	override func loadView() {
		self.view = signUpCompleteView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureBinding() {
		let inputDidAppear = self.rx.viewDidAppear

		let input = SignUpViewCompleteViewModel.Input(inputDidAppear: inputDidAppear,
																	 inputTapNextButton: signUpCompleteView.nextButton.rx.tap)

		let output = viewModel.transform(input: input)

		output.signUpComplte
			.drive(with: self) { owner, _ in
				owner.signUpCompleteView.configureUI()
			}.disposed(by: disposeBag)

		output.outputError
			.drive(with: self) { owner, error in
				owner.signUpCompleteView.configureUI(error)
			}.disposed(by: disposeBag)

		output.outputTapNextButton
			.drive(with: self) { owner, value in
				guard let value else { return }
				if value {
					owner.view.window?.rootViewController = TabbarViewController()
				} else {
					owner.navigationController?.popToRootViewController(animated: true)
				}
			}.disposed(by: disposeBag)
	}
}
