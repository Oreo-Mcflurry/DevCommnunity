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
	private let requestManager = PostRequestManager()
	private var next = ""
	private var partyPost: DetailViewSectionModel = DetailViewSectionModel(header: "", items: [], row: .skeleton)

	struct Input {
		let inputOffset: ControlProperty<CGPoint>
		let inputHeartButton: Observable<EventPost>
		let inputWebJoinButton: ControlEvent<Void>
		let inputViewDidAppear: Observable<EventPost>
		let inputDidSelect: ControlEvent<PartyPost>
		let inputPostAddButon: Observable<EventPost>
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
		let outputDidSelect: Driver<PartyPost>
		let outputPostAddButon: Driver<EventPost>
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

		input.inputViewDidAppear
			.bind(with: self) { owner, value in
				print("==============\(value.isLiked)")
				outputHeartButton.accept(value.isLiked)
			}.disposed(by: disposeBag)

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
				let query = PostsRequestModel(next: "", product_id: value.requestProductID)
				return self.requestManager.getPartyPosts(query: query)
			}
			.subscribe(with: self) { owner, value in
				switch value {
				case .success(let result):
					if result.data.isEmpty {
						outputPartyPost.accept([DetailViewSectionModel(header: "", items: [PartyPost()], row: .empty)])
					} else {
						owner.partyPost = DetailViewSectionModel(header: "", items: result.data, row: .data)
						outputPartyPost.accept([owner.partyPost])
					}
				case .failure(_):
					outputError.accept(Void())
				}

			}.disposed(by: disposeBag)

		input.inputHeartButton
			.flatMap {
				let query = LikeRequestModel(like_status: !$0.isLiked)
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
						  outputPartyPost: outputPartyPost.asDriver(), 
						  outputDidSelect: input.inputDidSelect.asDriver(), 
						  outputPostAddButon: input.inputPostAddButon.asDriver(onErrorJustReturn: EventPost()))
	}
}
