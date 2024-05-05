//
//  PartyPostAddViewModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/1/24.
//

import Foundation
import RxSwift
import RxCocoa

final class PartyPostAddViewModel: InputOutputViewModelProtocol {
	private let requestManger = PostRequestManager()

	struct Input {
		let inputWritebutton: Observable<WritePostRequestModel>
		let inputDatePicker: ControlProperty<Date>
		let inputIosStepper: ControlProperty<Double>
		let inputBackStepper: ControlProperty<Double>
		let inputPMStepper: ControlProperty<Double>
		let inputUIUXStepper: ControlProperty<Double>
	}

	struct Output {
		let outputSuccess: Driver<Bool>
		let outputDateTextField: Driver<String>
		let outputIosStepper: Driver<String>
		let outputBackStepper: Driver<String>
		let outputPMStepper: Driver<String>
		let outputUIUXStepper: Driver<String>
	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputSuccess = BehaviorRelay(value: false)
		let outputDateTextField = BehaviorRelay(value: "")
		let outputIosStepper = BehaviorRelay(value: "")
		let outputBackStepper = BehaviorRelay(value: "")
		let outputPMStepper = BehaviorRelay(value: "")
		let outputUIUXStepper = BehaviorRelay(value: "")

		input.inputWritebutton
			.flatMap {
				self.requestManger.writePost(data: $0)
			}
			.subscribe(with: self) { owner, value in
				switch value {
				case .success(_):
					outputSuccess.accept(true)
				case .failure(_):
					outputSuccess.accept(false)
				}
			}.disposed(by: disposeBag)

		input.inputDatePicker
			.bind(with: self) { _, value in
				outputDateTextField.accept(DateFormatter.formatter.string(from: value))
			}.disposed(by: disposeBag)

		input.inputBackStepper
			.bind(with: self) { _, value in
				outputBackStepper.accept("백엔드 \(Int(value))명")
			}.disposed(by: disposeBag)

		input.inputIosStepper
			.bind(with: self) { _, value in
				outputIosStepper.accept("iOS \(Int(value))명")
			}.disposed(by: disposeBag)

		input.inputPMStepper
			.bind(with: self) { _, value in
				outputPMStepper.accept("PM \(Int(value))명")
			}.disposed(by: disposeBag)

		input.inputUIUXStepper
			.bind(with: self) { _, value in
				outputUIUXStepper.accept("UI/UX \(Int(value))명")
			}.disposed(by: disposeBag)

		return Output(outputSuccess: outputSuccess.asDriver(),
						  outputDateTextField: outputDateTextField.asDriver(),
						  outputIosStepper: outputIosStepper.asDriver(),
						  outputBackStepper: outputBackStepper.asDriver(),
						  outputPMStepper: outputPMStepper.asDriver(),
						  outputUIUXStepper: outputUIUXStepper.asDriver())
	}
}
