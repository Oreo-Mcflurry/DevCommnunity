//
//  PartyDetailViewModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/29/24.
//

import Foundation
import RxSwift
import RxCocoa

final class PartyDetailViewModel: InputOutputViewModelProtocol {
	struct Input {
		let inputBookMarkButton: ControlEvent<Void>
		let inputJoinButton: ControlEvent<Void>
	}

	struct Output {
		let outputBookMarkButton: Driver<Void>
		let outputJoinButton: Driver<Void>
	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputBookMarkButton = BehaviorRelay(value: Void())
		return Output(outputBookMarkButton: outputBookMarkButton.asDriver(),
						  outputJoinButton: input.inputJoinButton.asDriver())
	}
}
