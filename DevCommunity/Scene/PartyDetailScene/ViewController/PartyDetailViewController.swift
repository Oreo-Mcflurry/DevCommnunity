//
//  PartyDetailViewController.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/29/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class PartyDetailViewController: BaseViewController {
	private let partyDetailView = PartyDetailView()
	private let partyDetailViewModel = PartyDetailViewModel()
	private let tableHeaderView = PartyDetailHeaderView()
	private let inputpartyPost: BehaviorRelay<PartyPost>

	init(_ partyPost: PartyPost) {
		self.inputpartyPost.accept(partyPost)
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	override func loadView() {
		self.view = partyDetailView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "팀원 모집"
		partyDetailView.partyTableView.delegate = self
	}

	override func configureBinding() {
		let dataSource = RxTableViewSectionedAnimatedDataSource<AppliedPostSectionModel> (animationConfiguration: AnimationConfiguration(insertAnimation: .fade)) { data, tableView, indexPath, item in

			if data[indexPath.section].row == .empty {
				guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.identifier, for: indexPath) as? EmptyTableViewCell else { fatalError() }
				cell.configureUI()
				return cell
			} else {
				guard let cell = tableView.dequeueReusableCell(withIdentifier: AppliedTableViewCell.identifier, for: indexPath) as? AppliedTableViewCell else { fatalError() }
				cell.configureUI(item)
				return cell
			}
		}

		let inputBookMarkButton = partyDetailView.bookmarkButton.rx.tap.map { self.partyPost }
		let inputviewDidAppear = self.rx.viewDidAppear.map { self.partyPost }
		let input = PartyDetailViewModel.Input(inputBookMarkButton: inputBookMarkButton,
															inputJoinButton: partyDetailView.joinButton.rx.tap,
															inputviewDidAppear: inputviewDidAppear)

		let output = partyDetailViewModel.transform(input: input)

		output.outputJoinButton
			.drive(with: self) { owner, _ in
				let vc = PartyJoinViewController(<#T##partyPost: PartyPost##PartyPost#>)
				owner.navigationController?.pushViewController(vc, animated: true)
			}.disposed(by: disposeBag)

		output.outputIsJoined
			.drive(with: self) { owner, value in
				owner.partyDetailView.joinButton.isEnabled = !value
				owner.partyDetailView.joinButton.backgroundColor = !value ? .accent : .lightGray
			}
			.disposed(by: disposeBag)

		output.outputJoinButtonText
			.drive(with: self) { owner, value in
				owner.partyDetailView.joinButton.setTitle(value, for: .normal)
			}.disposed(by: disposeBag)

		output.outputBookMarkButton
			.drive(with: self) { owner, value in
				owner.partyDetailView.bookmarkButton.setImage(value ? UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark"), for: .normal)
			}.disposed(by: disposeBag)

		output.outputApplied
			.drive(self.partyDetailView.partyTableView.rx.items(dataSource: dataSource))
			.disposed(by: disposeBag)
	}
}

extension PartyDetailViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		tableHeaderView.configureUI(partyPost)
		return tableHeaderView
	}
}

