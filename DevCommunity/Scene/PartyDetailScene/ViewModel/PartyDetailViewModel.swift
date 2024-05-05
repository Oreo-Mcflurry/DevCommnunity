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
	private let requestManager = PostRequestManager()

	struct Input {
		let inputBookMarkButton: ControlEvent<Void>
		let inputJoinButton: ControlEvent<Void>
		let inputviewDidAppear: Observable<PartyPost>
	}

	struct Output {
		let outputBookMarkButton: Driver<Void>
		let outputJoinButton: Driver<Void>
		let outputIsJoined: Driver<Bool>
		let outputJoinButtonText: Driver<String>
	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputBookMarkButton = BehaviorRelay(value: Void())
		let outputIsJoined = BehaviorRelay(value: false)
		let outputJoinButtonText = BehaviorRelay(value: "")

		input.inputviewDidAppear
			.flatMap { self.requestManager.getOnePost(postID: $0.postID) }
			.bind(with: self) { owner, value in
				switch value {
				case .success(let result):
					outputIsJoined.accept(result.isJoined || result.isCreator)

					let text = result.isJoined ? "이미 가입되어 있습니다" : result.isCreator ? "만든이는 가입할 수 없습니다" : "참가신청"
					outputJoinButtonText.accept(text)
				case .failure(_):
					break
				}
			}.disposed(by: disposeBag)

		return Output(outputBookMarkButton: outputBookMarkButton.asDriver(),
						  outputJoinButton: input.inputJoinButton.asDriver(),
						  outputIsJoined: outputIsJoined.asDriver(),
						  outputJoinButtonText: outputJoinButtonText.asDriver())
	}
}
