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

	private let defaultDiscriptionLabel = UILabel()
	private let nickNameTextField = BaseTextField()
	private let introduceTextField = BaseTextField()
	private let selectDiscriptionLabel = UILabel()
	let selectSegmentedControl = UISegmentedControl()

	override func configureHierarchy() {
		[scrollView, nextButton].forEach { addSubview($0) }
		[contentView].forEach { scrollView.addSubview($0) }
		[defaultDiscriptionLabel, nickNameTextField, introduceTextField, selectDiscriptionLabel, selectSegmentedControl].forEach { contentView.addSubview($0) }
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

		defaultDiscriptionLabel.snp.makeConstraints {
			$0.top.equalTo(contentView)
			$0.horizontalEdges.equalTo(contentView).inset(20)
		}

		nickNameTextField.snp.makeConstraints {
			$0.top.equalTo(defaultDiscriptionLabel.snp.bottom).offset(20)
			$0.horizontalEdges.equalTo(contentView).inset(20)
			$0.height.equalTo(60)
		}

		introduceTextField.snp.makeConstraints {
			$0.top.equalTo(nickNameTextField.snp.bottom).offset(20)
			$0.horizontalEdges.equalTo(contentView).inset(20)
			$0.height.equalTo(60)
		}

		selectDiscriptionLabel.snp.makeConstraints {
			$0.top.equalTo(introduceTextField.snp.bottom).offset(30)
			$0.horizontalEdges.equalTo(contentView).inset(20)
		}

		selectSegmentedControl.snp.makeConstraints {
			$0.top.equalTo(selectDiscriptionLabel.snp.bottom).offset(20)
			$0.horizontalEdges.equalTo(contentView).inset(20)
			$0.bottom.equalTo(contentView)
		}
	}

	override func configureView() {
		scrollView.alwaysBounceVertical = true

		nextButton.setTitle("다음", for: .normal)
		nextButton.backgroundColor = .lightGray
		nextButton.layer.cornerRadius = 10

		defaultDiscriptionLabel.text = "닉네임과 소개"
		defaultDiscriptionLabel.font = .boldSystemFont(ofSize: 20)

		nickNameTextField.placeholder = "닉네임"
		nickNameTextField.text = UserDefaults.standard[.userNickname]

		introduceTextField.placeholder = "한줄 소개"

		selectDiscriptionLabel.text = "지원 직무"
		selectDiscriptionLabel.font = .boldSystemFont(ofSize: 20)

		selectSegmentedControl.insertSegment(withTitle: "Test", at: 0, animated: false)
		selectSegmentedControl.insertSegment(withTitle: "Test1", at: 0, animated: false)
	}
}

#if DEBUG
#Preview(body: {
	PartyJoinViewController().toPreview()
})
#endif
