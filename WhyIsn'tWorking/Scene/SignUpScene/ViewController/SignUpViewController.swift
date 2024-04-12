//
//  SignUpViewController.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/11/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpViewController: BaseViewController {

	private let viewModel = SignUpViewModel()
	private let signUpView = SignUpView()

	override func loadView() {
		self.view = signUpView
		let rightButton = UIBarButtonItem(title: "Test", style: .plain, target: self, action: #selector(test))
		navigationItem.rightBarButtonItem = rightButton
	}

	@objc func test() {
		signUpView.test()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}
