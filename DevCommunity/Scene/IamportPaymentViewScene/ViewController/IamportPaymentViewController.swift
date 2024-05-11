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

class IamportPaymentViewController: BaseViewController {
	private let iamportPaymentView = IamportPaymentView()
	private let viewModel = IamportPaymentViewModel()

	override func loadView() {
		self.view = iamportPaymentView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureBinding() {
		let inputIamportResult = PublishRelay<IamportResponse>()
		let input = IamportPaymentViewModel.Input(inputViewDidLoad: self.rx.viewDidLoad,
																inputIamportResult: inputIamportResult)

		let output = viewModel.transform(input: input)

		output.outputViewDidLoad
			.drive(with: self) { owner, value in
				Iamport.shared.payment(viewController: self,
											  userCode: APIKey.portoneUserCode.rawValue,
											  payment: value) { response in
					if let response {
						inputIamportResult.accept(response)
					}
				}
			}.disposed(by: disposeBag)
	}
}
