//
//  BaseViewController.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit
import Toast

class BaseViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		configureView()
		configureBinding()
	}
	
	func configureView() { }
	func configureBinding() { }

	enum ToastKind: String {
		case loginError = "로그인 정보가 없습니다."
		case loginSuccess = "로그인 성공!"
		case signUp = "회원가입 성공!"
		case serverError = "서버의 연결이 불안정 합니다.\n나중에 시도해주세요."
	}

	func showToast(_ message: ToastKind) {
		self.view.makeToast(message.rawValue)
	}

	deinit {
		print("Deinit")
	}
}
