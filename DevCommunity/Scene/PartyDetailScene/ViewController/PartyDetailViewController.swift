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

	override func loadView() {
		self.view = partyDetailView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		partyDetailView.configureUI(partyPost)
		navigationItem.title = "팀원 모집"
	}
}
