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

	private let requestManager = PostRequestManager()

	struct Input {
		let inputRefresh: ControlEvent<Void>
		let inputDidAppear: Observable<Void>
		let inputWillAppear: Observable<Void>
		let inputDidSelect: Observable<(EventPost, IndexPath)>
	}

	struct Output {
		let outputRefresh: Driver<[EventsPostsSectionModel]>
		let outputWillAppear: Driver<Void>
		let outputError: Driver<Void>
		let outputDidSelect: Driver<(EventPost, IndexPath)>
	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputRefresh: BehaviorRelay<[EventsPostsSectionModel]> = BehaviorRelay(value: [])
		let outputError = BehaviorRelay(value: Void())

		Observable<[EventsPostsSectionModel]>
			.just([EventsPostsSectionModel(header: "", items: [EventPost()], row: .skeleton)])
			.bind(with: self) { owner, value in
				outputRefresh.accept(value)
			}
			.disposed(by: disposeBag)

		Observable.merge(input.inputRefresh.asObservable(), input.inputDidAppear)
			.flatMap { _ in
				self.requestManager.getEventPosts().asObservable()
			}
			.delay(.seconds(1), scheduler: MainScheduler.asyncInstance)
			.subscribe(with: self) { _, value in
				switch value {
				case .success(let result):
					outputRefresh.accept(self.groupPostsByMonth(posts: result.data))
				case .failure(_):
					outputError.accept(Void())
				}

			}
			.disposed(by: disposeBag)

		return Output(outputRefresh: outputRefresh.asDriver(), 
						  outputWillAppear: input.inputWillAppear.asDriver(onErrorJustReturn: Void()),
						  outputError: outputError.asDriver(),
						  outputDidSelect: input.inputDidSelect.asDriver(onErrorJustReturn: (EventPost(), IndexPath(row: 0, section: 0))))
	}

	private func groupPostsByMonth(posts: [EventPost]) -> [EventsPostsSectionModel] {
		var groupedPosts: [Int: [EventPost]] = [:]

		let sortedPost = posts.sorted { lhs, rhs in
			lhs.month > rhs.month
		}

		for post in sortedPost {
			if post.dateStart <= Date() { continue }
			let month = post.month
			if var monthPosts = groupedPosts[month] {
				monthPosts.append(post)
				groupedPosts[month] = monthPosts
			} else {
				groupedPosts[month] = [post]
			}
		}

		let sortedKeys = groupedPosts.keys.sorted()
		var sections: [EventsPostsSectionModel] = []
		for month in sortedKeys {
			let header = "\(month)월"
			if let items = groupedPosts[month] {
				let sortedItem = items.sorted { lhs, rhs in
					lhs.time < rhs.time
				}

				let section = EventsPostsSectionModel(header: header, items: sortedItem, row: .data)
				sections.append(section)
			}
		}

		return sections
	}
}
