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

final class DetailViewController: BaseViewController {
	private let viewModel = DetailViewModel()
	private let detailView = DetailView()
	private let disposeBag = DisposeBag()

	override func loadView() {
		self.view = detailView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}

	override func configureBinding() {
		let inputWillAppear = self.rx.sentMessage(#selector(UIViewController.viewWillAppear(_:))).map { _ in }
	}
}
