//
//  PartyPostAddViewController.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/1/24.
//

import UIKit
import RxSwift
import RxCocoa

final class PartyPostAddViewController: BaseEndEditingViewController {
	private let partyPostAddView = PartyPostAddView()
	private let viewModel = PartyPostAddViewModel()
	private let postButton = UIBarButtonItem(title: "게시", style: .plain, target: PartyPostAddViewController.self, action: nil)
	var eventPost = EventPost()

	override func loadView() {
		self.view = partyPostAddView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "모집 글 작성"
	}
}
