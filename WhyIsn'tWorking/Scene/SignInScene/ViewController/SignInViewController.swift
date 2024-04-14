//
//  SignInVIewController.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/11/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

import Alamofire

final class SignInViewController: BaseViewController {

	private let signInView = SignInView()
	private let signInViewModel = SignInViewModel()
	private let disposeBag = DisposeBag()

	override func loadView() {
		self.view = signInView
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		let loginModel = LoginRequestModel(email: "yuiop10239@naver.com", password: "123124")
		RequestManager().requestLogin(loginModel)
			.bind(with: self) { owner, value in
				print(value)
			}.disposed(by: disposeBag)
	}
}
