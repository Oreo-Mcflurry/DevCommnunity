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
				self.requestLogin($0)
					.catchAndReturn(false)
			}.subscribe { result in
				outputTapLoginButton.accept(result)
			}.disposed(by: disposeBag)


		return Output(outputIsEnabled: outputIsEnabled.asDriver(),
						  outputBackButton: outputBackButton.asDriver(),
						  outputTapLoginButton: outputTapLoginButton.asDriver(),
						  outputTapSignupButton: input.inputTapSignupButton.asDriver())
	}

	private func requestLogin(_ request: LoginRequestModel) -> Single<Bool> {
		return Single<Bool>.create { single in
			RequestManager().callRequest(.login(query: request), type: LoginModel.self)
				.subscribe(with: self) { _, data in
					UserDefaults.standard[.emailId] = data.email
					UserDefaults.standard[.password] = request.password
					UserDefaults.standard[.accessToken] = data.accessToken
					UserDefaults.standard[.refreshToken] = data.refreshToken
					UserDefaults.standard[.userId] = data.user_id
					single(.success(true))
				} onFailure: { _, error in
					single(.failure(error))
				}
		}
	}
}
