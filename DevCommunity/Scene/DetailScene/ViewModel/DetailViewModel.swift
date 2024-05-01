//
//  DetailViewModek.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/22/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailViewModel: InputOutputViewModelProtocol {
	private let requestManager = RequestManager()
	private var next = ""
	private var partyPost: DetailViewSectionModel = DetailViewSectionModel(header: "", items: [], row: .skeleton)

	struct Input {
		let inputOffset: ControlProperty<CGPoint>
		let inputHeartButton: Observable<EventPost>
		let inputWebJoinButton: ControlEvent<Void>
		let inputViewDidAppear: Observable<EventPost>
	}

	struct Output {
		let outputHeroImageOpacity: Driver<Float>
		let outputOffset: Driver<CGPoint>
		let outputHeroImageTransform: Driver<CGAffineTransform>
		let outputTitleViewIsHidden: Driver<Bool>
		let outputTitleViewOpacity: Driver<Float>
		let outputHeartButton: Driver<Bool>
		let outputWebJoinButton: Driver<Void>
		let outputError: Driver<Void>
		let outputPartyPost: Driver<[DetailViewSectionModel]>
	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputHeroImageOpacity: BehaviorRelay<Float> = BehaviorRelay(value: 0.0)
		let outputHeroImageTransform: BehaviorRelay<CGAffineTransform> = BehaviorRelay(value: CGAffineTransform(scaleX: 0, y: 0))
		let outputTitleViewIsHidden = BehaviorRelay(value: false)
		let outputTitleViewOpacity: BehaviorRelay<Float> = BehaviorRelay(value: 0.0)
		let outputOffset = BehaviorRelay(value: CGPoint(x: 0, y: 0))

		let outputPartyPost: BehaviorRelay<[DetailViewSectionModel]> = BehaviorRelay(value: [])
		let outputError = BehaviorRelay(value: Void())

		let outputHeartButton = BehaviorRelay(value: false)

		Observable.just([DetailViewSectionModel(header: "", items: [PartyPost()], row: .skeleton)])
		.bind(to: outputPartyPost)
		.disposed(by: disposeBag)

		input.inputOffset
			.observe(on:MainScheduler.instance)
			.bind(with: self) { owner, value in
				let scaleFactor = 1 + (max(0, -value.y) / 120)
				outputHeroImageTransform.accept(CGAffineTransform(scaleX: scaleFactor, y: scaleFactor))

				let opacityFactor = Float(max(0, 1-value.y/100))
				outputHeroImageOpacity.accept(opacityFactor)

				if 1-opacityFactor < 0.1 {
					outputTitleViewIsHidden.accept(true)
				} else {
					outputTitleViewIsHidden.accept(false)
					outputTitleViewOpacity.accept(1-opacityFactor)
				}

				outputOffset.accept(CGPoint(x: value.x, y: max(-150, value.y)))
			}.disposed(by: disposeBag)

		input.inputViewDidAppear
			.flatMap { value in
				let query = PostsRequestModel(next: self.next, limit: "5", product_id: value.requestProductID)
				return self.requestManager.getPartyPost(query: .party(query: query))
					.catch { _ in
						outputError.accept(Void())
						return Observable.never()
					}
			}
			.subscribe(with: self) { owner, value in
				owner.next = value.nextCursor
				if value.data.isEmpty {
					owner.partyPost = DetailViewSectionModel(header: "", items: [PartyPost()], row: .empty)
				} else {
					owner.partyPost = DetailViewSectionModel(header: "", items: value.data, row: .data)
				}

				outputPartyPost.accept([owner.partyPost])
			}.disposed(by: disposeBag)

		input.inputHeartButton
			.flatMap {
				let query = LikeRequestModel(like_status: !$0.isLiked)
				return self.requestManager.requestLike(postID: $0.postID, query: query)
					.catchAndReturn(LikeResultModel(like_status: false))
			}
			.map { $0.like_status }
			.bind(to: outputHeartButton)
			.disposed(by: disposeBag)

		return Output(outputHeroImageOpacity: outputHeroImageOpacity.asDriver(),
						  outputOffset: outputOffset.asDriver(),
						  outputHeroImageTransform: outputHeroImageTransform.asDriver(),
						  outputTitleViewIsHidden: outputTitleViewIsHidden.asDriver(),
						  outputTitleViewOpacity: outputTitleViewOpacity.asDriver(),
						  outputHeartButton: outputHeartButton.asDriver(),
						  outputWebJoinButton: input.inputWebJoinButton.asDriver(),
						  outputError: outputError.asDriver(),
						  outputPartyPost: outputPartyPost.asDriver())
	}
}
