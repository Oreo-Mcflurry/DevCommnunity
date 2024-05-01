//
//  DetailViewController.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/22/24.
//

import UIKit
import RxSwift
import RxCocoa
import SkeletonView
import RxDataSources

final class DetailViewController: BaseViewController {
	private let viewModel = DetailViewModel()
	private let detailView = DetailView()
	private let titleView = TitleView()
	private let disposeBag = DisposeBag()
	let tableHeaderView = DetailHeaderView()

	var eventPost = EventPost()
	private let heartButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: DetailViewController.self, action: nil)
	private let webJoinButton = UIBarButtonItem(image: UIImage(systemName: "globe"), style: .plain, target: DetailViewController.self, action: nil)

	override func loadView() {
		self.view = detailView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureView() {
		self.tabBarController?.tabBar.isHidden = true
		titleView.configureUI(eventPost)
		heartButton.image = eventPost.isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
		self.navigationItem.rightBarButtonItems = [heartButton, webJoinButton]
		self.navigationItem.titleView = titleView
		detailView.detailTableView.delegate = self
	}

	override func configureBinding() {

		let dataSource = RxTableViewSectionedAnimatedDataSource<DetailViewSectionModel> (animationConfiguration: AnimationConfiguration(insertAnimation: .fade)) { data, tableView, indexPath, item in

			if data[indexPath.section].row == .empty {
				guard let cell = tableView.dequeueReusableCell(withIdentifier: PartyEmptyTableViewCell.identifier, for: indexPath) as? PartyEmptyTableViewCell else { fatalError() }
				tableView.visibleCells.forEach { $0.hideSkeleton() }
				tableView.separatorStyle = .none
				cell.selectionStyle = .none
				cell.isUserInteractionEnabled = false
				return cell
			}

			guard let cell = tableView.dequeueReusableCell(withIdentifier: PartyTableViewCell.identifier, for: indexPath) as? PartyTableViewCell else { fatalError() }

			if data[indexPath.section].row == .data {
				cell.configureUI(item)
			} else {
				cell.configureSkeleton()
			}

			return cell
		}

		let inputViewDidAppear = self.rx.viewDidAppear.map { self.eventPost }
		let inputHeartButton = self.heartButton.rx.tap.map { self.eventPost }

		let input = DetailViewModel.Input(inputOffset: detailView.detailTableView.rx.contentOffset,
													 inputHeartButton: inputHeartButton,
													 inputWebJoinButton: webJoinButton.rx.tap,
													 inputViewDidAppear: inputViewDidAppear,
													 inputDidSelect: detailView.detailTableView.rx.modelSelected(PartyPost.self))

		let output = viewModel.transform(input: input)

		output.outputHeroImageOpacity
			.drive(self.tableHeaderView.heroImageView.layer.rx.opacity)
			.disposed(by: disposeBag)

		output.outputHeroImageTransform
			.drive(self.tableHeaderView.heroImageView.rx.transform)
			.disposed(by: disposeBag)

		output.outputTitleViewIsHidden
			.drive(with: self) { owner, value in
				owner.navigationItem.titleView?.isHidden = value
			}.disposed(by: disposeBag)

		output.outputTitleViewOpacity
			.drive(with: self) { owner, value in
				owner.navigationItem.titleView?.layer.opacity = value
			}.disposed(by: disposeBag)

		output.outputPartyPost
			.drive(self.detailView.detailTableView.rx.items(dataSource: dataSource))
			.disposed(by: disposeBag)

		output.outputWebJoinButton
			.drive(with: self) { owner, _ in
				let vc = WebViewController()
				print(owner.eventPost.webURL)
				vc.url = owner.eventPost.webURL
				owner.navigationController?.pushViewController(vc, animated: true)
			}.disposed(by: disposeBag)

		output.outputHeartButton
			.drive(with: self) { owner, value in
				owner.eventPost.isLiked = value
//				owner.heartButton.image = value ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
			}.disposed(by: disposeBag)

		output.outputOffset
			.drive(self.detailView.detailTableView.rx.contentOffset)
			.disposed(by: disposeBag)

		output.outputDidSelect
			.drive(with: self) { owner, value in
				print(value)
				let vc = PartyDetailViewController()
				vc.partyPost = value
				owner.navigationController?.pushViewController(vc, animated: true)
			}.disposed(by: disposeBag)
	}
}

extension DetailViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		tableHeaderView.configureUI(eventPost)
		return tableHeaderView
	}
}
