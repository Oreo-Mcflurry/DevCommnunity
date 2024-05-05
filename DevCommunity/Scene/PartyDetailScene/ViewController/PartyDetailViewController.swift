//
//  PartyDetailViewController.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/29/24.
//

import UIKit
import RxSwift
import RxCocoa

final class PartyDetailViewController: BaseViewController {
	private let partyDetailView = PartyDetailView()
	private let partyDetailViewModel = PartyDetailViewModel()
	var partyPost = PartyPost()
	let tapJoinCompleteButton: PublishRelay<Void> = PublishRelay()

	override func loadView() {
		self.view = partyDetailView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		partyDetailView.configureUI(partyPost)
		navigationItem.title = "팀원 모집"
	}

	override func configureBinding() {
		let input = PartyDetailViewModel.Input(inputBookMarkButton: partyDetailView.bookmarkButton.rx.tap,
															inputJoinButton: partyDetailView.joinButton.rx.tap, 
															inputviewDidAppear: self.rx.viewDidAppear.map { self.partyPost })

		let output = partyDetailViewModel.transform(input: input)

		output.outputJoinButton
			.drive(with: self) { owner, _ in
				let vc = PartyJoinViewController()
				vc.partyPost = owner.partyPost
				vc.tapJoinCompleteButton = owner.tapJoinCompleteButton
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

		tapJoinCompleteButton
			.bind(with: self) { owner, _ in
				owner.partyDetailView.joinButton.isEnabled = false
				owner.partyDetailView.joinButton.backgroundColor = .lightGray
				owner.partyDetailView.joinButton.setTitle("이미 가입되어 있습니다", for: .normal)
				owner.partyPost.isJoined = true
			}.disposed(by: disposeBag)
	}
}
