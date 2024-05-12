//
//  IamportPaymentView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/11/24.
//

import UIKit
import SnapKit

final class IamportPaymentView: BaseUIView {
	private let paymentLabelsView = BaseLabelsView()

	override func configureHierarchy() {
		[paymentLabelsView].forEach { addSubview($0) }
	}

	override func configureLayout() {
		paymentLabelsView.snp.makeConstraints {
			$0.top.equalTo(self.safeAreaLayoutGuide)
			$0.horizontalEdges.equalTo(self).inset(20)
		}
	}

	override func configureView() {
		paymentLabelsView.mainLabel.text = "광고 제거 구매\n진행 중 입니다."
		paymentLabelsView.subLabel.text = "잠시만 기다려주세요"
	}

	func configureUI(_ data: (String, String)) {
		paymentLabelsView.mainLabel.text = data.0
		paymentLabelsView.subLabel.text = data.1
	}
}

