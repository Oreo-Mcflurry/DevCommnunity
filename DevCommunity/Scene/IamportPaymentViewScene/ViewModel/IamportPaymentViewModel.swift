//
//  IamportPaymentViewModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/11/24.
//

import Foundation
import RxSwift
import RxCocoa
import iamport_ios

final class IamportPaymentViewModel: InputOutputViewModelProtocol {
	private let requestManager = PayRequestManager()
	struct Input {
		let inputViewDidLoad: Observable<Void>
		let inputIamportResult: PublishRelay<IamportResponse>
	}

	struct Output {
		let outputViewDidLoad: Driver<IamportPayment>
	}

	private(set) var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputViewDidLoad = BehaviorRelay(value: createPaymentData())

		input.inputViewDidLoad
			.map { self.createPaymentData() }
			.bind(to: outputViewDidLoad)
			.disposed(by: disposeBag)

		input.inputIamportResult
			.map {
				PayValidationModel(imp_uid: $0.imp_uid ?? "",
										 post_id: "663f24788077c5d86ecc7870",
										 productName: "DevCommunity 광고제거")
			}
			.flatMap { self.requestManager.getPayValidation(query: $0) }
			.subscribe(with: self) { owner, value in
				switch value {
				case .success:
					<#code#>
				case .error:
					<#code#>
				case .alreadyPay:
					<#code#>
				}
			}.disposed(by: disposeBag)

		return Output(outputViewDidLoad: outputViewDidLoad.asDriver())
	}

	private func createPaymentData() -> IamportPayment {
		 return IamportPayment(pg: PG.html5_inicis.makePgRawName(pgId: "INIpayTest"),
									  merchant_uid: "iOS_test_\(UUID())",
									  amount: "100").then {
			 $0.pay_method = PayMethod.card.rawValue
			 $0.name = "DevCommunity 광고제거"
			 $0.buyer_name = "유인호"
			 $0.app_scheme = "devcommunity.yoo.paytest"
		 }
	 }
}
