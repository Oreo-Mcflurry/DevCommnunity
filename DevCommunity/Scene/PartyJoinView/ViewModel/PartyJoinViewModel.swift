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
	private let requestManger = PostRequestManager()
	private var partyPost = PartyPost()

	struct Input {
		let inputpartyPost: BehaviorRelay<PartyPost>
		let inputIntroduceText: ControlProperty<String?>
		let inputNextButton: Observable<JoinRequestModel>
	}

	struct Output {
		let outputNextButtonIsEnabled: Driver<Bool>
		let outputNextButton: Driver<Bool>
		let outputpartyPost: Driver<PartyPost>
	}

	private(set) var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputNextButtonIsEnabled = BehaviorRelay(value: false)
		let outputNextButton = BehaviorRelay(value: false)
		let outputpartyPost = BehaviorRelay(value: partyPost)

		input.inputpartyPost
			.bind(with: self) { owner, value in
				owner.partyPost = value
				outputpartyPost.accept(value)
			}.disposed(by: disposeBag)

		input.inputIntroduceText
			.orEmpty
			.bind(with: self) { _, value in
				outputNextButtonIsEnabled.accept(value.count >= 10)
			}.disposed(by: disposeBag)

		input.inputNextButton
			.flatMap { 
				self.requestManger.writeJoinPost(postID: self.partyPost.postID, data: $0)
			}
			.subscribe(with: self) { _, value in
				switch value {
				case .success(_):
					outputNextButton.accept(true)
				case .failure(_):
					outputNextButton.accept(false)
				}
			}.disposed(by: disposeBag)

		return Output(outputNextButtonIsEnabled: outputNextButtonIsEnabled.asDriver(),
						  outputNextButton: outputNextButton.asDriver(), 
						  outputpartyPost: outputpartyPost.asDriver())
	}
}
