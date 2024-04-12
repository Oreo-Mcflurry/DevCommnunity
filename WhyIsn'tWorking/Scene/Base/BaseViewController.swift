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
		configureHierarchy()
		configureLayout()
		configureView()
		configureBinding()
	}

	func configureHierarchy() { }
	func configureLayout() { }
	func configureView() { }
	func configureBinding() { }

	enum ToastKind: String {
		case searchError = "검색결과가 없습니다."
	}

	func showToast(_ message: ToastKind) {
		self.view.makeToast(message.rawValue)
	}

	deinit {
		print("Deinit")
	}
}
