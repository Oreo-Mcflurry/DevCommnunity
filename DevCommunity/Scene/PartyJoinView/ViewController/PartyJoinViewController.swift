//
//  PartyJoinViewController.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/3/24.
//

import UIKit
import RxSwift
import RxCocoa

final class PartyJoinViewController: BaseViewController {
	private let partyJoinView = PartyJoinView()
	private let viewModel = PartyPostAddViewModel()
	private let disposeBag = DisposeBag()

	override func loadView() {
		self.view = partyJoinView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}
