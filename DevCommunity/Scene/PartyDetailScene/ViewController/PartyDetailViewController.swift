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
	var partyPost = PartyPost()

	override func loadView() {
		self.view = partyDetailView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "팀원 모집"
		partyDetailView.partyTableView.delegate = self
	}

	override func configureBinding() {
//		let dataSource = RxTableViewSectionedAnimatedDataSource<JoinPostSectionModel> (animationConfiguration: AnimationConfiguration(insertAnimation: .fade)) { data, tableView, indexPath, item in
//		}

		let inputBookMarkButton = partyDetailView.bookmarkButton.rx.tap.map { self.partyPost }
		let inputviewDidAppear = self.rx.viewDidAppear.map { self.partyPost }
		let input = PartyDetailViewModel.Input(inputBookMarkButton: inputBookMarkButton,
															inputJoinButton: partyDetailView.joinButton.rx.tap,
															inputviewDidAppear: inputviewDidAppear)

		let output = partyDetailViewModel.transform(input: input)

		output.outputJoinButton
			.drive(with: self) { owner, _ in
				let vc = PartyJoinViewController()
				vc.partyPost = owner.partyPost
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
	}
}

extension PartyDetailViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		tableHeaderView.configureUI(partyPost)
		return tableHeaderView
	}
}

