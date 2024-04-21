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

	override func loadView() {
		self.view = eventsView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureView() {
		self.navigationItem.title = "Events"
	}

	override func configureBinding() {
		let dataSource = RxTableViewSectionedAnimatedDataSource<PostsSectionModel>(animationConfiguration: AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .fade, deleteAnimation: .left)) { data, tableView, indexPath, item in
			guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.description(), for: indexPath) as? EventsTableViewCell else { fatalError("Dequeue EventsTableViewCell Error") }
			cell.configureCell(item)
			return cell
		} titleForHeaderInSection: { data, index in
			return "\(index)"
		}

		let inputDidAppear = self.rx.sentMessage(#selector(UIViewController.viewDidAppear(_:)))
			.map { _ in	}.debug()

		let input = EventsViewModel.Input(inputRefresh: eventsView.refreshControl.rx.controlEvent(.valueChanged),
													 inputDidAppear: inputDidAppear)

		let output = viewModel.transform(input: input)

		output.outputRefresh
			.drive(eventsView.eventTableView.rx.items(dataSource: dataSource))
			.disposed(by: disposeBag)

		output.outputRefresh
			.map { _ in }
			.drive(with: self) { owner, _ in
				DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
					owner.eventsView.refreshControl.endRefreshing()
				}
			}
			.disposed(by: disposeBag)
	}
}
