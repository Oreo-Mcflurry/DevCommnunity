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
	private var partyPost = PartyPost()

	struct Input {
		let inputBookMarkButton: ControlEvent<Void>
		let inputJoinButton: ControlEvent<Void>
		let inputpartyPost: BehaviorRelay<PartyPost>
	}

	struct Output {
		let outputpartyPost: Driver<PartyPost>
		let outputBookMarkButton: Driver<Bool>
		let outputJoinButton: Driver<PartyPost>
		let outputIsJoined: Driver<Bool>
		let outputJoinButtonText: Driver<String>
		let outputApplied: Driver<[AppliedPostSectionModel]>
	}

	private(set) var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputBookMarkButton = BehaviorRelay(value: false)
		let outputIsJoined = BehaviorRelay(value: false)
		let outputJoinButtonText = BehaviorRelay(value: "")
		let outputApplied: BehaviorRelay<[AppliedPostSectionModel]> = BehaviorRelay(value: [])
		let outputpartyPost = BehaviorRelay(value: partyPost)
		let outputJoinButton = BehaviorRelay(value: partyPost)

		input.inputpartyPost
			.bind(with: self) { owner, value in
				owner.partyPost = value
				outputpartyPost.accept(value)
			}.disposed(by: disposeBag)

		input.inputJoinButton
			.bind(with: self) { owner, _ in
				outputJoinButton.accept(owner.partyPost)
			}.disposed(by: disposeBag)

		input.inputpartyPost
			.flatMap { self.requestManager.getOnePost(postID: $0.postID) }
			.bind(with: self) { owner, value in
				switch value {
				case .success(let result):
					outputBookMarkButton.accept(result.isBookmarked)

					outputIsJoined.accept(result.isJoined || result.isCreator)
					let text = result.isJoined ? "이미 가입되어 있습니다" : result.isCreator ? "만든이는 가입할 수 없습니다" : "참가신청"
					outputJoinButtonText.accept(text)

					if result.appliedInfo.isEmpty {
						outputApplied.accept([AppliedPostSectionModel(header: "", items: [AppliedInfo()], row: .empty)])
					} else {
						outputApplied.accept([AppliedPostSectionModel(header: "", items: result.appliedInfo, row: .data)])
					}
				case .failure(_):
					break
				}
			}.disposed(by: disposeBag)

		input.inputBookMarkButton
			.flatMap {
				let query = LikeRequestModel(like_status: self.partyPost.isBookmarked)
				return self.requestManager.likePost(postID: self.partyPost.postID, query: query)
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

		return Output(outputpartyPost: outputpartyPost.asDriver(),
						  outputBookMarkButton: outputBookMarkButton.asDriver(),
						  outputJoinButton: outputJoinButton.asDriver(),
						  outputIsJoined: outputIsJoined.asDriver(),
						  outputJoinButtonText: outputJoinButtonText.asDriver(), 
						  outputApplied: outputApplied.asDriver())
	}
}
