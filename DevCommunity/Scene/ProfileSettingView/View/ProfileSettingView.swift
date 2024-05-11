//
//  ProfileSettingView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/4/24.
//

import UIKit
import SnapKit

class ProfileSettingView: BaseUIView {
	private let scrollView = UIScrollView()
	private let contentView = UIView()

	let nickNameTextField = BaseTextField()
	let phoneNumberTextField = BaseTextField()

	override func configureHierarchy() {
		[scrollView].forEach { addSubview($0) }
		[contentView].forEach { scrollView.addSubview($0) }
		[nickNameTextField, phoneNumberTextField].forEach { contentView.addSubview($0) }
	}

	override func configureLayout() {
		scrollView.snp.makeConstraints {
			$0.edges.equalTo(self)
		}

		contentView.snp.makeConstraints {
			$0.verticalEdges.equalTo(scrollView)
			$0.width.equalTo(scrollView)
		}

		nickNameTextField.snp.makeConstraints {
			$0.top.equalTo(contentView).offset(10)
			$0.horizontalEdges.equalTo(contentView).inset(20)
			$0.height.equalTo(60)
		}

		phoneNumberTextField.snp.makeConstraints {
			$0.top.equalTo(nickNameTextField.snp.bottom).offset(20)
			$0.horizontalEdges.equalTo(contentView).inset(20)
			$0.height.equalTo(60)
			$0.bottom.equalTo(contentView)
		}
	}

	override func configureView() {
		scrollView.alwaysBounceVertical = true

		nickNameTextField.placeholder = "닉네임"
		nickNameTextField.text = UserDefaults.standard[.userNickname]
		phoneNumberTextField.placeholder = "전화번호"
		nickNameTextField.text = UserDefaults.standard[.phoneNum]
	}
}
