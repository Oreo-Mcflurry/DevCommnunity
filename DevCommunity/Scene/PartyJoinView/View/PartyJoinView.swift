//
//  PartyJoinView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/3/24.
//

import UIKit
import SnapKit
import SwiftUI

final class PartyJoinView: BaseUIView {
	private let scrollView = UIScrollView()
	private let contentView = UIView()

	let nextButton = UIButton()

	private let nickNameTextField = BaseTextField()
	private let introduceTextField = BaseTextField()
	private let selectDiscriptionLabel = UILabel()

	override func configureHierarchy() {
		[scrollView, nextButton].forEach { addSubview($0) }
		[contentView].forEach { scrollView.addSubview($0) }
		[nickNameTextField, introduceTextField].forEach { contentView.addSubview($0) }
	}

	override func configureLayout() {
		scrollView.snp.makeConstraints {
			$0.edges.equalTo(self)
		}

		contentView.snp.makeConstraints {
			$0.verticalEdges.equalTo(scrollView)
			$0.width.equalTo(scrollView)
		}

		nextButton.snp.makeConstraints {
			$0.bottom.equalTo(scrollView.snp.bottom).inset(20)
			$0.horizontalEdges.equalTo(scrollView).inset(20)
			$0.height.equalTo(40)
		}

		nickNameTextField.snp.makeConstraints {
			$0.top.equalTo(contentView)
			$0.horizontalEdges.equalTo(contentView).inset(20)
			$0.height.equalTo(60)
		}

		introduceTextField.snp.makeConstraints {
			$0.top.equalTo(nickNameTextField.snp.bottom).offset(20)
			$0.horizontalEdges.equalTo(contentView).inset(20)
			$0.height.equalTo(60)
			$0.bottom.equalTo(contentView)
		}
	}

	override func configureView() {
		scrollView.alwaysBounceVertical = true

		nextButton.setTitle("다음", for: .normal)
		nextButton.backgroundColor = .lightGray

		nickNameTextField.placeholder = "닉네임"
		nickNameTextField.text = UserDefaults.standard[.userNickname]

		introduceTextField.placeholder = "한줄소개"
	}
}

#if DEBUG
#Preview(body: {
	PartyJoinViewController().toPreview()
})
#endif
