//
//  SignUpBottomSheetVIew.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/13/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpBottomSheetViewController: BaseViewController {
	private let viewModel = SignUpBottomSheetViewModel()
	private let signUpBottomSheet = SignUpBottomSheetView()
	var inputNextButton = PublishRelay<Void>()

	override func loadView() {
		self.view = signUpBottomSheet
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		let detentIdentifier = UISheetPresentationController.Detent.Identifier("customDetent")
		let customDetent = UISheetPresentationController.Detent.custom(identifier: detentIdentifier) { _ in
			 return 200
		}

		if let sheetPresentationController {
			sheetPresentationController.detents = [customDetent]
			sheetPresentationController.preferredCornerRadius = 30
			sheetPresentationController.prefersGrabberVisible = true
		}
	}

	override func configureBinding() {
		let inputTermsofService = BehaviorRelay(value: false)
		let inputPrivacy = BehaviorRelay(value: false)

		signUpBottomSheet.termsOfServiceCheck.checkBoxImageButton.rx.tap
			.bind(with: self) { owner, _ in
				inputTermsofService.accept(owner.signUpBottomSheet.termsOfServiceCheck.toggle())
			}.disposed(by: disposeBag)

		signUpBottomSheet.privacyCheck.checkBoxImageButton.rx.tap
			.bind(with: self) { owner, _ in
				inputPrivacy.accept(owner.signUpBottomSheet.privacyCheck.toggle())
			}.disposed(by: disposeBag)

		let input = SignUpBottomSheetViewModel.Input(inputTermsofService: inputTermsofService,
																	inputPrivacy: inputPrivacy, 
																	inputTapNextButton: signUpBottomSheet.nextButton.rx.tap)

		let output = viewModel.transform(input: input)

		output.outputIsEnabled
			.drive(with: self) { owner, value in
				owner.signUpBottomSheet.nextButton.isEnabled = value
				owner.signUpBottomSheet.nextButton.backgroundColor = value ? UIColor.accent : UIColor.lightGray
			}.disposed(by: disposeBag)

		output.outputTapNextButton
			.drive(with: self) { owner, _ in
				owner.dismiss(animated: true)
					owner.inputNextButton.accept(Void())
			}.disposed(by: disposeBag)
	}
}
