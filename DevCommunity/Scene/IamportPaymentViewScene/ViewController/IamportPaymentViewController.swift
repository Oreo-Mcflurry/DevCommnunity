//
//  IamportPaymentView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/6/24.
//

import SwiftUI
import RxSwift
import RxCocoa
import iamport_ios

final class IamportPaymentViewController: BaseViewController {
	private let iamportPaymentView = IamportPaymentView()
	private let viewModel = IamportPaymentViewModel()

	override func loadView() {
		self.view = iamportPaymentView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.tabBarController?.tabBar.isHidden = true
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.tabBarController?.tabBar.isHidden = false
	}

	override func configureBinding() {
		let inputIamportResult = PublishRelay<IamportResponse>()
		let input = IamportPaymentViewModel.Input(inputViewDidAppear: self.rx.viewDidAppear,
																inputIamportResult: inputIamportResult)

		let output = viewModel.transform(input: input)

		output.outputViewDidAppear
			.drive(with: self) { owner, value in
				Iamport.shared.payment(viewController: owner,
											  userCode: APIKey.portoneUserCode.rawValue,
											  payment: value) { response in
					if let response {
						inputIamportResult.accept(response)
					}
				}
			}.disposed(by: disposeBag)

		output.outputDiscriptionLabel
			.drive(with: self) { owner, data in
				owner.iamportPaymentView.configureUI(data)
			}.disposed(by: disposeBag)
	}
}
