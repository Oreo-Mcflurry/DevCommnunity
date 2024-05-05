//
//  BaseEndEditingViewController.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/5/24.
//

import UIKit
import RxSwift

class BaseEndEditingViewController: BaseViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let tapGesture = UITapGestureRecognizer()
		view.addGestureRecognizer(tapGesture)

		tapGesture.rx.event
			.bind(with: self) { owner, _ in
				owner.view.endEditing(true)
			}.disposed(by: disposeBag)
	}
}
