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
import SkeletonView

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
		let dataSource = RxTableViewSectionedAnimatedDataSource<EventsPostsSectionModel>(animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .fade)) { data, tableView, indexPath, item in
			guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.description(), for: indexPath) as? EventsTableViewCell else { fatalError("Dequeue EventsTableViewCell Error") }

			if data[indexPath.section].row == .skeleton {
				cell.configureSkeleton()
			} else {
				cell.configureCell(item)
			}
			return cell
		} titleForHeaderInSection: { data, index in
			return "\(data[index].header)"
		}

		let inputDidAppear = self.rx.viewDidAppear

		let inputWillAppear = self.rx.viewWillAppear

		let inputDidSelect = Observable.zip(eventsView.eventTableView.rx.modelSelected(EventPost.self).asObservable(),
																	 eventsView.eventTableView.rx.itemSelected.asObservable())

		let input = EventsViewModel.Input(inputRefresh: eventsView.refreshControl.rx.controlEvent(.valueChanged),
													 inputDidAppear: inputDidAppear,
													 inputWillAppear: inputWillAppear,
													 inputDidSelect: inputDidSelect)

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

		output.outputWillAppear
			.drive(with: self) { owner, _ in
				owner.tabBarController?.tabBar.isHidden = false
			}
			.disposed(by: disposeBag)

		output.outputDidSelect
			.drive(with: self) { owner, value in
				let vc = DetailViewController()
				vc.eventPost = value.0
				owner.eventsView.eventTableView.reloadRows(at: [value.1], with: .automatic)
				owner.navigationController?.pushViewController(vc, animated: true)
			}.disposed(by: disposeBag)

		output.outputError
			.drive(with: self) { owner, _ in
				owner.showToast(.serverError)
			}.disposed(by: disposeBag)
	}
}
