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
	private let requestManager = RequestManager()
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
			}.flatMap { self.requestManager.createLogin(query: $0) }
			.subscribe(with: self) { _, _ in
				outputLoginResult.accept(true)
			} onError: { _, _ in
				outputLoginResult.accept(false)
			}.disposed(by: disposeBag)


		return Output(outputLoginResult: outputLoginResult.asDriver())
	}
}
