//
//  PartyJoinViewModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/3/24.
//

import Foundation
import RxSwift
import RxCocoa

final class PartyJoinViewModel: InputOutputViewModelProtocol {
	struct Input {
		let inputIntroduceText: ControlProperty<String?>
	}

	struct Output {
		let nextButtonIsEnabled: Driver<Bool>
	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let nextButtonIsEnabled = BehaviorRelay(value: false)
		
		input.inputIntroduceText
			.orEmpty
			.bind(with: self) { _, value in
				nextButtonIsEnabled.accept(value.count >= 10)
			}.disposed(by: disposeBag)

		return Output(nextButtonIsEnabled: nextButtonIsEnabled.asDriver())
	}
}
