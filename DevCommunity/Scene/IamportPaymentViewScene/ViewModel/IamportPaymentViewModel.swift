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
		let outputDiscriptionLabel: Driver<(String, String)>
	}

	private(set) var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputViewDidLoad = BehaviorRelay(value: createPaymentData())
		let outputDiscriptionLabel = BehaviorRelay(value: ("", ""))

		input.inputViewDidLoad
			.flatMap { self.requestManager.getIsUserBought() }
			.bind(with: self) { owner, value in
				switch value {
				case .success(let result):
					if result.data.filter({ $0.post_id == "663f24788077c5d86ecc7870" }).isEmpty {
						outputViewDidLoad.accept(self.createPaymentData())
					} else {
						outputDiscriptionLabel.accept(self.getDiscriptionLabel(.alreadyPay))
					}
				case .failure(_):
					outputViewDidLoad.accept(self.createPaymentData())
				}
			}.disposed(by: disposeBag)

		input.inputIamportResult
			.map {
				PayValidationModel(imp_uid: $0.imp_uid ?? "",
										 post_id: "663f24788077c5d86ecc7870",
										 productName: "DevCommunity 광고제거")
			}
			.flatMap { self.requestManager.getPayValidation(query: $0) }
			.map { self.getDiscriptionLabel(PayStatusCode.getPayEnum($0)) }
			.bind(to: outputDiscriptionLabel)
			.disposed(by: disposeBag)

		return Output(outputViewDidLoad: outputViewDidLoad.asDriver(), 
						  outputDiscriptionLabel: outputDiscriptionLabel.asDriver())
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

	private func getDiscriptionLabel(_ data: PayStatusCode) -> (String, String) {
		switch data {
		case .success:
			return ("광고 제거를\n구매하셨습니다.", "감사합니다!")
		case .error:
			return ("구매를 진행을\n실패하였습니다.", "다음에 다시시도해주세요.")
		case .alreadyPay:
			return ("광고 제거를\n이미 구매하셨습니다!", "또 구매하고 싶으시면 감사합니다!.")
		}
	}
}
