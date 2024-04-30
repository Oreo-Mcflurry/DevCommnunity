//
//  SignUpBottomSheetViewModel.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/13/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SignUpBottomSheetViewModel: InputOutputViewModelProtocol {
	struct Input {
		let inputTermsofService: BehaviorRelay<Bool>
		let inputPrivacy: BehaviorRelay<Bool>
		let inputTapNextButton: ControlEvent<Void>
	}

	struct Output {
		let outputIsEnabled: Driver<Bool>
		let outputTapNextButton: Driver<Void>
	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputIsEnabled = BehaviorRelay(value: false)

		let result = Observable.combineLatest(input.inputTermsofService, input.inputPrivacy)
			.map { $0 && $1 }
			.share()

		result
			.bind(to: outputIsEnabled)
			.disposed(by: disposeBag)

		return Output(outputIsEnabled: outputIsEnabled.asDriver(),
						  outputTapNextButton: input.inputTapNextButton.asDriver())
	}
}
