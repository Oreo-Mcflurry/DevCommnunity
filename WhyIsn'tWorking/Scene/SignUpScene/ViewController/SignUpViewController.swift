//
//  SignUpViewController.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/11/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpViewController: BaseViewController {

	private let viewModel = SignUpViewModel()
	private let signUpView = SignUpView()
	private let disposeBag = DisposeBag()
	private let inputNextButton = PublishRelay<Void>()

	override func loadView() {
		self.view = signUpView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		signUpView.nextTextField(3)
	}

	override func configureBinding() {

		let inputDidBegin = PublishRelay<Int>()
		let inputDidEndOnExit = PublishRelay<(String?, Int)>()
		let inputDidEnd = PublishRelay<Int>()

		signUpView.textFields.enumerated().forEach { (index, item) in
			item.rx.controlEvent(.editingDidBegin)
				.map { index }
				.bind(to: inputDidBegin)
				.disposed(by: disposeBag)

			item.rx.controlEvent(.editingDidEndOnExit)
				.map { (item.text, index) }
				.bind(to: inputDidEndOnExit)
				.disposed(by: disposeBag)

			item.rx.controlEvent(.editingDidEnd)
				.map { index }
				.bind(to: inputDidEnd)
				.disposed(by: disposeBag)
		}

		let input = SignUpViewModel.Input(inputDidBegin: inputDidBegin,
													 inputDidEnd: inputDidEnd,
													 inputDidEndOnExit: inputDidEndOnExit,
													 inputNextButton: inputNextButton)

		let output = viewModel.transform(input: input)

		output.outputDidBegin
			.drive(with: self) { owner, value in
				owner.signUpView.textFields[value].borderActiveColor = .systemBlue
			}.disposed(by: disposeBag)

		output.outputDidEnd
			.drive(with: self) { owner, value in
				owner.signUpView.textFields[value].borderActiveColor = .gray
			}.disposed(by: disposeBag)

		output.outputDidEndOnExit
			.drive(with: self) { owner, value in
				if value.0 && value.1 == -1 {
					let vc = SignUpBottomSheetViewController()
					vc.inputNextButton = owner.inputNextButton
					owner.present(vc, animated: true)
				} else if value.0 {
					owner.signUpView.nextTextField(value.1)
				}
			}.disposed(by: disposeBag)

		output.outputMainLabelText
			.drive(signUpView.mainLabel.rx.text)
			.disposed(by: disposeBag)

		output.outputSubLabelText
			.drive(signUpView.subLabel.rx.text)
			.disposed(by: disposeBag)

		output.outputNextButton
			.drive(with: self) { owner, _ in
				owner.navigationController?.pushViewController(SignInViewController(), animated: true)
			}.disposed(by: disposeBag)
	}
}
