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
	private let requestManager = RequestManager()

	struct Input {
		let inputEmailText: ControlProperty<String?>
		let inputPasswordText: ControlProperty<String?>
		let inputTapLoginButton: PublishSubject<(String?, String?)>
		let inputTapSignupButton: ControlEvent<Void>
	}

	struct Output {
		let outputIsEnabled: Driver<Bool>
		let outputBackButton: Driver<UIColor>
		let outputTapLoginButton: Driver<Bool>
		let outputTapSignupButton: Driver<Void>
	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputIsEnabled = BehaviorRelay(value: false)
		let outputBackButton = BehaviorRelay(value: UIColor.lightGray)
		let outputTapLoginButton = BehaviorRelay(value: false)

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

		input.inputTapLoginButton
			.map { LoginRequestModel(email: $0.0 ?? "", password: $0.1 ?? "") }
			.flatMap {
				self.requestManager.createLogin(query: $0)
			}.subscribe(with: self, onNext: { _, data in
				UserDefaults.standard[.userNickname] = data.nick
				UserDefaults.standard[.emailId] = data.email
				UserDefaults.standard[.accessToken] = data.accessToken
				UserDefaults.standard[.refreshToken] = data.refreshToken
				UserDefaults.standard[.userId] = data.user_id
				outputTapLoginButton.accept(true)
			}, onError: { _, _ in
				outputTapLoginButton.accept(false)
			}).disposed(by: disposeBag)


		return Output(outputIsEnabled: outputIsEnabled.asDriver(),
						  outputBackButton: outputBackButton.asDriver(),
						  outputTapLoginButton: outputTapLoginButton.asDriver(),
						  outputTapSignupButton: input.inputTapSignupButton.asDriver())
	}
}
