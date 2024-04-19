//
//  HomeViewController.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/15/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class EventsViewController: BaseViewController {
	private let viewModel = EventsViewModel()
	private let eventsView = EventsView()
	private let disposeBag = DisposeBag()

	var tests = BehaviorSubject(value: [
		PostsSectionModel(header: "111", items: [
			EventPost(),
			EventPost(),
			EventPost(),
			EventPost(),
		])

	])

	override func loadView() {
		self.view = eventsView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureBinding() {
		let dataSource = RxTableViewSectionedAnimatedDataSource<PostsSectionModel>(animationConfiguration: AnimationConfiguration(insertAnimation: .top, reloadAnimation: .fade, deleteAnimation: .left)) { data, tableView, indexPath, item in
			let cell = tableView.dequeueReusableCell(withIdentifier: "Test", for: indexPath)
			cell.textLabel?.text = "Test"
			return cell
		}

		dataSource.canEditRowAtIndexPath = { dataSource, index in
			return true
		}

		dataSource.canMoveRowAtIndexPath = { _, _ in
			return true
		}

		self.tests
			.bind(to: eventsView.eventCollectionView.rx.items(dataSource: dataSource))
			.disposed(by: disposeBag)

		eventsView.refreshControl.rx.controlEvent(.valueChanged)
			.bind(with: self) { _, _ in
				self.eventsView.refreshControl.endRefreshing()
			}.disposed(by: disposeBag)
	}
}
