//
//  SignInViewModel.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/11/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SignInViewModel: InputOutputViewModelProtocol {
	private let requestManager = AuthRequestManager()

	struct Input {
		let inputEmailText: ControlProperty<String?>
		let inputPasswordText: ControlProperty<String?>
		let inputTapLoginButton: PublishSubject<(String?, String?)>
		let inputTapSignupButton: ControlEvent<Void>
	}

	struct Output {
		let outputIsEnabled: Driver<Bool>
		let outputTapLoginButton: Driver<Bool>
		let outputTapSignupButton: Driver<Void>
	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputIsEnabled = BehaviorRelay(value: false)
		let outputTapLoginButton = BehaviorRelay(value: false)

		let validation = Observable.combineLatest(input.inputEmailText.orEmpty, input.inputPasswordText.orEmpty)
			.map { $0.0.contains("@") && $0.1.count > 8 }
			.share()

		validation
			.bind(to: outputIsEnabled)
			.disposed(by: disposeBag)

		input.inputTapLoginButton
			.map { LoginRequestModel(email: $0.0 ?? "", password: $0.1 ?? "") }
			.flatMap {
				UserDefaults.standard.saveLoginRequest($0)
				return self.requestManager.loginRequest($0)
			}.subscribe(with: self) { _, value in
				switch value {
				case .success(let result):
					UserDefaults.standard.saveLoginResult(result)
					outputTapLoginButton.accept(true)
				case .failure(_):
					outputTapLoginButton.accept(false)
				}
			}.disposed(by: disposeBag)


		return Output(outputIsEnabled: outputIsEnabled.asDriver(),
						  outputTapLoginButton: outputTapLoginButton.asDriver(),
						  outputTapSignupButton: input.inputTapSignupButton.asDriver())
	}
}
