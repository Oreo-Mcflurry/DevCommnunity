//
//  SignUpViewCompleteScene.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/13/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpViewCompleteViewController: BaseViewController {
	private let signUpCompleteView = SignUpCompleteView()
	private let viewModel = SignUpViewCompleteViewModel()

	override func loadView() {
		self.view = signUpCompleteView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}
