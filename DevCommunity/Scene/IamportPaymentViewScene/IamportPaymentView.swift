//
//  IamportPaymentView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/6/24.
//

import SwiftUI
import iamport_ios

struct IamportPaymentView: UIViewControllerRepresentable {

  func makeUIViewController(context: Context) -> UIViewController {
	 let view = IamportPaymentViewController()
	  view.requestIamportPayment()
	 return view
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

class IamportPaymentViewController: UIViewController {

  func requestIamportPayment() {
	 let payment = createPaymentData()

	 Iamport.shared.payment(viewController: self,
									userCode: APIKey.portoneUserCode.rawValue, payment: payment) { [weak self] response in
		 print("결과 : \(response)")
	 }
  }

	// 아임포트 결제 데이터 생성
	func createPaymentData() -> IamportPayment {
		return IamportPayment(pg: PG.html5_inicis.makePgRawName(pgId: "INIpayTest"),
									 merchant_uid: "iOS_test_\(UUID())",
									 amount: "100").then {
			$0.pay_method = PayMethod.card.rawValue
			$0.name = "DevCommnity 광고제거"
			$0.buyer_name = "유인호"
			$0.app_scheme = "devcommunity.yoo.paytest"
		}
	}
}
