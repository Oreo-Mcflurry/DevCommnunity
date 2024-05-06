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
		let inputBookMarkButton: Observable<PartyPost>
		let inputJoinButton: ControlEvent<Void>
		let inputviewDidAppear: Observable<PartyPost>
	}

	struct Output {
		let outputBookMarkButton: Driver<Bool>
		let outputJoinButton: Driver<Void>
		let outputIsJoined: Driver<Bool>
		let outputJoinButtonText: Driver<String>
	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputBookMarkButton = BehaviorRelay(value: false)
		let outputIsJoined = BehaviorRelay(value: false)
		let outputJoinButtonText = BehaviorRelay(value: "")

		input.inputviewDidAppear
			.flatMap { self.requestManager.getOnePost(postID: $0.postID) }
			.bind(with: self) { owner, value in
				switch value {
				case .success(let result):
					outputBookMarkButton.accept(result.isBookmarked)

					outputIsJoined.accept(result.isJoined || result.isCreator)
					let text = result.isJoined ? "이미 가입되어 있습니다" : result.isCreator ? "만든이는 가입할 수 없습니다" : "참가신청"
					outputJoinButtonText.accept(text)
				case .failure(_):
					break
				}
			}.disposed(by: disposeBag)

		input.inputBookMarkButton
			.flatMap {
				let query = LikeRequestModel(like_status: !$0.isBookmarked)
				return self.requestManager.likePost(postID: $0.postID, query: query)
			}
			.map {
				switch $0 {
				case .success(let result):
					return result.like_status
				case .failure(_):
					return false
				}
			}
			.bind(to: outputBookMarkButton)
			.disposed(by: disposeBag)

		return Output(outputBookMarkButton: outputBookMarkButton.asDriver(),
						  outputJoinButton: input.inputJoinButton.asDriver(),
						  outputIsJoined: outputIsJoined.asDriver(),
						  outputJoinButtonText: outputJoinButtonText.asDriver())
	}
}
