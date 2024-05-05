//
//  PartyJoinViewController.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/3/24.
//

import UIKit
import RxSwift
import RxCocoa

final class PartyJoinViewController: BaseEndEditingViewController {
	private let partyJoinView = PartyJoinView()
	private let viewModel = PartyJoinViewModel()
	var partyPost = PartyPost()
	var tapJoinCompleteButton: PublishRelay<Void>!

	override func loadView() {
		self.view = partyJoinView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		partyJoinView.configureUI(partyPost)
	}

	override func configureBinding() {
		let inputNextButton = partyJoinView.nextButton.rx.tap.map { (self.partyPost, self.partyJoinView.getJoinRequestModel()) }

		let input = PartyJoinViewModel.Input(inputIntroduceText: partyJoinView.introduceTextField.rx.text,
														 inputNextButton: inputNextButton)

		let output = viewModel.transform(input: input)

		output.outputNextButtonIsEnabled
			.drive(with: self) { owner, value in
				owner.partyJoinView.nextButton.isEnabled = value

				owner.partyJoinView.nextButton.backgroundColor = value ? .accent : .lightGray
			}.disposed(by: disposeBag)

		output.outputNextButton
			.drive(with: self) { owner, value in
				if value {
					owner.tapJoinCompleteButton.accept(Void())
					owner.navigationController?.popViewController(animated: true)
				} else {
					owner.showToast(.serverError)
				}
			}.disposed(by: disposeBag)
	}
}
