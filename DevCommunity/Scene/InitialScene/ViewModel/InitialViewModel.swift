//
//  InitialViewModel.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/16/24.
//

import Foundation
import RxSwift
import RxCocoa

final class InitialViewModel: InputOutputViewModelProtocol {
	private let authManger = AuthRequestManager()
	struct Input {
		let inputDidAppear: Observable<Void>
	}

	struct Output {
		let outputLoginResult: Driver<Bool>
	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputLoginResult = BehaviorRelay(value: false)

		input.inputDidAppear
			.map {
				LoginRequestModel(email: UserDefaults.standard[.emailId], password: UserDefaults.standard[.password])
			}.flatMap { self.authManger.loginRequest($0) }
			.subscribe(with: self) { _, value in
				
				switch value {
				case .success(let result):
					UserDefaults.standard.saveLoginResult(result)
					outputLoginResult.accept(true)

				case.failure(_):
					outputLoginResult.accept(false)
				}

			}.disposed(by: disposeBag)


		return Output(outputLoginResult: outputLoginResult.asDriver())
	}
}
