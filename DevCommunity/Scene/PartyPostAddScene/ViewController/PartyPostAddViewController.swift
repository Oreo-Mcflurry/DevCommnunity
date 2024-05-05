//
//  PartyPostAddViewController.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/1/24.
//

import UIKit
import RxSwift
import RxCocoa

final class PartyPostAddViewController: BaseEndEditingViewController {
	private let partyPostAddView = PartyPostAddView()
	private let viewModel = PartyPostAddViewModel()
	private let postButton = UIBarButtonItem(title: "게시", style: .plain, target: PartyPostAddViewController.self, action: nil)
	var eventPost = EventPost()

	override func loadView() {
		self.view = partyPostAddView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "팀원 모집 게시물 작성"
		navigationItem.rightBarButtonItem = postButton
		partyPostAddView.configureUI(eventPost)
	}

	override func configureBinding() {

		let inputWritebutton = postButton.rx.tap.map { self.partyPostAddView.getWritePostRequestModel(self.eventPost.requestProductID) }

		let input = PartyPostAddViewModel.Input(inputWritebutton: inputWritebutton,
															 inputDatePicker: self.partyPostAddView.datePicker.rx.date,
															 inputIosStepper: self.partyPostAddView.iosStepper.stepper.rx.value,
															 inputBackStepper: self.partyPostAddView.backStepper.stepper.rx.value,
															 inputPMStepper: self.partyPostAddView.pmStepper.stepper.rx.value,
															 inputUIUXStepper: self.partyPostAddView.uiuxStepper.stepper.rx.value)

		let output = viewModel.transform(input: input)

		output.outputSuccess
			.drive(with: self) { owner, value in
				if value {
					owner.navigationController?.popViewController(animated: true)
				} else {
					owner.showToast(.serverError)
				}
			}.disposed(by: disposeBag)

		output.outputDateTextField
			.drive(self.partyPostAddView.datePickerTextField.rx.text)
			.disposed(by: disposeBag)

		output.outputIosStepper
			.drive(self.partyPostAddView.iosStepper.mainLabel.rx.text)
			.disposed(by: disposeBag)

		output.outputBackStepper
			.drive(self.partyPostAddView.backStepper.mainLabel.rx.text)
			.disposed(by: disposeBag)

		output.outputPMStepper
			.drive(self.partyPostAddView.pmStepper.mainLabel.rx.text)
			.disposed(by: disposeBag)

		output.outputUIUXStepper
			.drive(self.partyPostAddView.uiuxStepper.mainLabel.rx.text)
			.disposed(by: disposeBag)
	}
}
