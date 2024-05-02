//
//  PartyPostAddViewController.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/1/24.
//

import UIKit
import RxSwift
import RxCocoa

final class PartyPostAddViewController: BaseViewController {
	private let partyPostAddView = PartyPostAddView()
	private let viewModel = PartyPostAddViewModel()
	private let disposeBag = DisposeBag()

	override func loadView() {
		self.view = partyPostAddView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}
