//
//  SignInViewModel.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/11/24.
//

import Foundation
import UIKit.UIColor
import RxSwift
import RxCocoa

final class SignInViewModel: InputOutputViewModelProtocol {
	struct Input {
		let inputEmailText: ControlProperty<String?>
		let inputPasswordText: ControlProperty<String?>
		let inputTapLoginButton: ControlEvent<Void>
		let inputTapSignupButton: ControlEvent<Void>
	}

	struct Output {
		let outputIsEnabled: Driver<Bool>
		let outputBackButton: Driver<UIColor>
		let outputTapLoginButton: Driver<Void>
		let outputTapSignupButton: Driver<Void>
	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputIsEnabled = BehaviorRelay(value: false)
		let outputBackButton = BehaviorRelay(value: UIColor.lightGray)

		let validation = Observable.combineLatest(input.inputEmailText.orEmpty, input.inputPasswordText.orEmpty)
			.map { $0.0.contains("@") && $0.1.count > 8 }
			.share()

		validation
			.bind(to: outputIsEnabled)
			.disposed(by: disposeBag)

		validation
			.map { $0 ? UIColor.systemBlue : UIColor.lightGray }
			.bind(to: outputBackButton)
			.disposed(by: disposeBag)

		return Output(outputIsEnabled: outputIsEnabled.asDriver(),
						  outputBackButton: outputBackButton.asDriver(),
						  outputTapLoginButton: input.inputTapLoginButton.asDriver(),
						  outputTapSignupButton: input.inputTapSignupButton.asDriver())
	}
}
