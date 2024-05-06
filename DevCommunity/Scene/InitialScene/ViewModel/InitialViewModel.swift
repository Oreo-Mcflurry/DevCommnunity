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
		let outputLoginResult = PublishRelay<Bool>()

		input.inputDidAppear
			.flatMap { self.authManger.accessTokenRequest() }
			.subscribe(with: self) { _, value in
				print(value)
				switch value {
				case .success(_):
					outputLoginResult.accept(true)
				case.failure(_):
					outputLoginResult.accept(false)
				}

			}.disposed(by: disposeBag)


		return Output(outputLoginResult: outputLoginResult.asDriver(onErrorJustReturn: false))
	}
}
