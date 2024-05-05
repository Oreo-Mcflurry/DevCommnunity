//
//  PartyPostAddView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/1/24.
//

import UIKit

import SnapKit

final class PartyPostAddView: BaseUIView {
	private let scrollView = UIScrollView()
	private let contentView = UIView()

	private let defaultDiscriptionLabel = UILabel()
	private let titleTextField = BaseTextField()
	private let datePickerTextField = BaseTextField()
	private let datePicker = UIDatePicker()

	private let introduceDiscriptionLabel = UILabel()
	private let introduceTextView = UITextView()
	private var introduceTextViewHeight: Double = 0

	override func configureHierarchy() {
		[scrollView].forEach { addSubview($0) }
		[contentView].forEach { scrollView.addSubview($0) }
		[defaultDiscriptionLabel, titleTextField, datePickerTextField, introduceDiscriptionLabel, introduceTextView].forEach { contentView.addSubview($0) }
	}

	override func configureLayout() {
		scrollView.snp.makeConstraints {
			$0.edges.equalTo(self)
		}

		contentView.snp.makeConstraints {
			$0.verticalEdges.equalTo(scrollView)
			$0.width.equalTo(scrollView)
		}

		defaultDiscriptionLabel.snp.makeConstraints {
			$0.top.equalTo(contentView).offset(20)
			$0.horizontalEdges.equalTo(contentView).inset(20)
		}

		titleTextField.snp.makeConstraints {
			$0.top.equalTo(defaultDiscriptionLabel.snp.bottom)
			$0.horizontalEdges.equalTo(contentView).inset(20)
			$0.height.equalTo(60)
		}

		datePickerTextField.snp.makeConstraints {
			$0.top.equalTo(titleTextField.snp.bottom).offset(20)
			$0.horizontalEdges.equalTo(contentView).inset(20)
			$0.height.equalTo(60)
		}

		introduceDiscriptionLabel.snp.makeConstraints {
			$0.top.equalTo(datePickerTextField.snp.bottom).offset(20)
			$0.horizontalEdges.equalTo(contentView).inset(20)
		}

		introduceTextView.snp.makeConstraints {
			$0.top.equalTo(introduceDiscriptionLabel.snp.bottom).offset(10)
			$0.horizontalEdges.equalTo(contentView).inset(20)
			$0.bottom.equalTo(contentView)
		}
	}

	override func configureView() {
		scrollView.alwaysBounceVertical = true
		defaultDiscriptionLabel.text = "기본 정보"
		defaultDiscriptionLabel.font = .boldSystemFont(ofSize: 20)

		titleTextField.placeholder = "제목"

		datePickerTextField.inputView = datePicker
		datePickerTextField.text = "\(Date())"
		datePickerTextField.placeholder = "마감일"

		datePicker.minimumDate = Date()
		datePicker.datePickerMode = .date
		datePicker.preferredDatePickerStyle = .wheels

		introduceDiscriptionLabel.text = "소개"
		introduceDiscriptionLabel.font = .boldSystemFont(ofSize: 20)

		introduceTextView.sizeToFit()
		introduceTextView.isScrollEnabled = false
		introduceTextView.delegate = self
		introduceTextView.layer.borderColor = UIColor.gray.cgColor
		introduceTextView.layer.borderWidth = 1
		introduceTextView.text = "소개글을 입력해주세요"
		introduceTextView.textColor = .lightGray
	}
}

extension PartyPostAddView: UITextViewDelegate {
	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.textColor == UIColor.lightGray {
			textView.text = ""
			textView.textColor = .black
		}
	}

	func textViewDidEndEditing(_ textView: UITextView) {
		if textView.text.isEmpty {
			textView.text = "소개글을 입력해주세요"
			textView.textColor = .lightGray
		}
	}
}


import SwiftUI
#Preview(body: {
	PartyPostAddViewController().toPreview()
})


