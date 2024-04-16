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
	var requestModel: SignUpRequetModel?
	private var isSuccess: Bool? = nil

	struct Input {
		let inputDidAppear: Observable<Void>
		let inputTapNextButton: ControlEvent<Void>
	}

	struct Output {
		let signUpComplte: Driver<Bool>
		let outputError: Driver<RequestManager.APIError>
		let outputTapNextButton: Driver<Bool?>
	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let signUpComplete = BehaviorRelay(value: false)
		let outputError = BehaviorRelay(value: RequestManager.APIError.urlError)
		let outputTapNextButton: BehaviorRelay<Bool?> = BehaviorRelay(value: nil)

		input.inputDidAppear
			.map { self.requestModel ?? SignUpRequetModel(email: "", password: "", nick: "", phoneNum: "")}
			.flatMap {
				RequestManager().createSignUp(data: $0)
			}
			.subscribe(with: self, onNext: { owner, _ in
				owner.isSuccess = true

				let login = LoginRequestModel(email: UserDefaults.standard[.emailId], password: UserDefaults.standard[.password])
				RequestManager().createLogin(query: login)
					.subscribe(with: self) { owner, _ in
						signUpComplete.accept(true)
					}.disposed(by: self.disposeBag)
			}, onError: { owner, error in
				owner.isSuccess = false
				if let error = error as? RequestManager.APIError {
					outputError.accept(error)
				}
			})
			.disposed(by: disposeBag)

		input.inputTapNextButton
			.map { self.isSuccess }
			.bind(to: outputTapNextButton)
			.disposed(by: disposeBag)

		return Output(signUpComplte: signUpComplete.asDriver(),
						  outputError: outputError.asDriver(), 
						  outputTapNextButton: outputTapNextButton.asDriver())
	}
}
