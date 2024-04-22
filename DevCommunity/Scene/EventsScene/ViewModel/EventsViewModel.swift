//
//  HomeViewModel.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/15/24.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

final class EventsViewModel: InputOutputViewModelProtocol {

	struct Input {
		let inputRefresh: ControlEvent<Void>
		let inputDidAppear: Observable<Void>
	}

	struct Output {
		let outputRefresh: Driver<[PostsSectionModel]>
		let outputError: Driver<Void>
	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputRefresh: BehaviorRelay<[PostsSectionModel]> = BehaviorRelay(value: [])
		let outputError = BehaviorRelay(value: Void())

		Observable.merge(input.inputRefresh.asObservable(), input.inputDidAppear)
			.debug()
			.flatMap { _ in
				RequestManager().getPosts(query: .event)
			}
			.debug()
			.map { $0.data }
			.map { self.groupPostsByMonth(posts: $0) }
			.subscribe(with: self, onNext: { _, value in
				outputRefresh.accept(value)
			}, onError: { _, _ in
				outputError.accept(Void())
			})
			.disposed(by: disposeBag)

		return Output(outputRefresh: outputRefresh.asDriver(),
						  outputError: outputError.asDriver())
	}

	private func groupPostsByMonth(posts: [EventPost]) -> [PostsSectionModel] {
		var groupedPosts: [Int: [EventPost]] = [:]

		let sortedPost = posts.sorted { lhs, rhs in
			lhs.month > rhs.month
		}
		// 월별로 이벤트 그룹화
		for post in sortedPost {
			let month = post.month
			if var monthPosts = groupedPosts[month] {
				monthPosts.append(post)
				groupedPosts[month] = monthPosts
			} else {
				groupedPosts[month] = [post]
			}
		}

		// PostsSectionModel로 변환
		let sortedKeys = groupedPosts.keys.sorted()
		var sections: [PostsSectionModel] = []
		for month in sortedKeys {
			let header = "\(month)월"
			let items = groupedPosts[month]!
			let section = PostsSectionModel(header: header, items: items)
			sections.append(section)
		}

		return sections
	}
}
