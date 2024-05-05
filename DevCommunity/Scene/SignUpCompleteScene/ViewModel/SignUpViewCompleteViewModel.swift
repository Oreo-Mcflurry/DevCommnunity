//
//  SignUpViewCompleteViewModel.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/13/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SignUpViewCompleteViewModel: InputOutputViewModelProtocol {
	private let requestManager = AuthRequestManager()
	var requestModel: SignUpRequetModel?

	private var isSuccess: Bool? = nil

	struct Input {
		let inputDidAppear: Observable<Void>
		let inputTapNextButton: ControlEvent<Void>
	}

	struct Output {
		let signUpComplte: Driver<Bool>
		let outputError: Driver<BaseRequestManager.RequestError?>
		let outputTapNextButton: Driver<Bool?>
	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let signUpComplete = BehaviorRelay(value: false)
		let outputError: BehaviorRelay<BaseRequestManager.RequestError?> = BehaviorRelay(value: nil)
		let outputTapNextButton: BehaviorRelay<Bool?> = BehaviorRelay(value: nil)

		input.inputDidAppear
			.flatMap { myClass -> Observable<SignUpRequetModel> in
				if let requestModel = self.requestModel {
					return Observable.just(requestModel)
				} else {
					return Observable.never()
				}
			}
			.flatMap {
				UserDefaults.standard.saveSignUpRequest($0)
				return self.requestManager.signUpRequest($0)
			}
			.subscribe(with: self) { owner, value in
				owner.isSuccess = true

				switch value {
				case .success(_):
					let login = LoginRequestModel(email: UserDefaults.standard[.emailId], password: UserDefaults.standard[.password])
					self.requestManager.loginRequest(login)
						.subscribe(with: self) { owner, loginResult in

							switch loginResult {
							case .success(let result):
								UserDefaults.standard.saveLoginResult(result)
								signUpComplete.accept(true)
							case .failure(_):
								outputError.accept(.urlError)
							}
						}
						.disposed(by: self.disposeBag)

				case .failure(_):
					outputError.accept(.urlError)
				}
			}.disposed(by: disposeBag)

		input.inputTapNextButton
			.map { self.isSuccess }
			.bind(to: outputTapNextButton)
			.disposed(by: disposeBag)

		return Output(signUpComplte: signUpComplete.asDriver(),
						  outputError: outputError.asDriver(), 
						  outputTapNextButton: outputTapNextButton.asDriver())
	}
}
