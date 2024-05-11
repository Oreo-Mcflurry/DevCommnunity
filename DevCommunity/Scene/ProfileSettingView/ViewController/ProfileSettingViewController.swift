//
//  ProfileSettingViewController.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/10/24.
//

import UIKit
import RxSwift
import RxCocoa

final class ProfileSettingViewController: BaseViewController {
	private let profileSettingView: ProfileSettingView
	private let viewModel: ProfileSettingViewModel
	private var saveBarButton: UIBarButtonItem

	init() {
		self.profileSettingView = ProfileSettingView()
		self.viewModel = ProfileSettingViewModel()
		self.saveBarButton = UIBarButtonItem(title: "저장", style: .plain, target: ProfileSettingViewController.self, action: nil)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		self.view = profileSettingView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureBinding() {
		let inputSaveButtonClicked = Observable.combineLatest(profileSettingView.nickNameTextField.rx.text, profileSettingView.phoneNumberTextField.rx.text)

		let input = ProfileSettingViewModel.Input(inputViewDidAppear: self.rx.viewDidAppear,
																inputSaveButtonClicked: inputSaveButtonClicked,
																inputNickNameTextField: profileSettingView.nickNameTextField.rx.text,
																inputPhoneNumTextField: profileSettingView.phoneNumberTextField.rx.text)

		let output = viewModel.transform(input: input)

		output.outputSaveButtonEnabled
			.drive(with: self) { owner, value in
				owner.saveBarButton.isEnabled = value
				owner.saveBarButton.tintColor = value ? .accent : .gray
			}.disposed(by: disposeBag)

		output.outputSaveButtonClicked
			.drive(with: self) { owner, _ in
				owner.navigationController?.popViewController(animated: true)
			}.disposed(by: disposeBag)

		output.outputViewDidAppear
			.drive(with: self) { owner, value in
				owner.profileSettingView.nickNameTextField.text = value.nick
				owner.profileSettingView.phoneNumberTextField.text = value.phoneNum
			}.disposed(by: disposeBag)

	}
}
