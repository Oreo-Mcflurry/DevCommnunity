//
//  InitialViewController.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/16/24.
//

import UIKit
import RxSwift
import RxCocoa

final class InitialViewController: BaseViewController {
	private let viewModel = InitialViewModel()
	private let initView = InitialView()
	private let disposeBag = DisposeBag()

	override func loadView() {
		self.view = initView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureBinding() {
		let inputDidAppear = self.rx.sentMessage(#selector(UIViewController.viewDidAppear(_:)))
			.map { _ in	}

		let input = InitialViewModel.Input(inputDidAppear: inputDidAppear)

		let output = viewModel.transform(input: input)

		output.outputLoginResult
			.drive(with: self) { owner, value in
				let vc = value ? TabbarViewController() : UINavigationController(rootViewController: SignInViewController())
				owner.view?.window?.rootViewController = vc
			}.disposed(by: disposeBag)
	}
}
