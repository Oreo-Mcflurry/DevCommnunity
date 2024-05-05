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

	override func loadView() {
		self.view = partyJoinView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		partyJoinView.configureUI(partyPost)
	}

	override func configureBinding() {
		let input = PartyJoinViewModel.Input(inputIntroduceText: partyJoinView.introduceTextField.rx.text)

		let output = viewModel.transform(input: input)

		output.nextButtonIsEnabled
			.drive(with: self) { owner, value in
				owner.partyJoinView.nextButton.isEnabled = value

				owner.partyJoinView.nextButton.backgroundColor = value ? .accent : .lightGray
			}.disposed(by: disposeBag)
	}
}
