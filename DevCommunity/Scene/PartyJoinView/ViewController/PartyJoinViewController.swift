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
	private let viewModel: PartyJoinViewModel
	private let inputpartyPost: BehaviorRelay<PartyPost>

	init(_ partyPost: PartyPost) {
		self.inputpartyPost.accept(partyPost)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		self.view = partyJoinView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureBinding() {
		let inputNextButton = partyJoinView.nextButton.rx.tap.map { self.partyJoinView.getJoinRequestModel() }

		let input = PartyJoinViewModel.Input(inputpartyPost: inputpartyPost,
														 inputIntroduceText: partyJoinView.introduceTextField.rx.text,
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
					owner.navigationController?.popViewController(animated: true)
				} else {
					owner.showToast(.serverError)
				}
			}.disposed(by: disposeBag)

		output.outputpartyPost
			.drive(with: self) { owner, value in
				owner.partyJoinView.configureUI(value)
			}.disposed(by: disposeBag)
	}
}
