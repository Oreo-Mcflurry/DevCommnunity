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

	let nextButton = UIButton()

	private let defaultDiscriptionLabel = UILabel()
	private let titleTextField = BaseTextField()
	let datePickerTextField = BaseTextField()
	let datePicker = UIDatePicker()

	private let peopleDiscriptionLabel = UILabel()
	let iosStepper = BaseStepperView()
	let backStepper = BaseStepperView()
	let pmStepper = BaseStepperView()
	let uiuxStepper = BaseStepperView()

	private let introduceDiscriptionLabel = UILabel()
	private let introduceTextView = UITextView()
	private var introduceTextViewHeight: Double = 0

	override func configureHierarchy() {
		[scrollView].forEach { addSubview($0) }
		[contentView].forEach { scrollView.addSubview($0) }
		[defaultDiscriptionLabel, titleTextField, datePickerTextField, peopleDiscriptionLabel, iosStepper, backStepper, pmStepper, uiuxStepper, introduceDiscriptionLabel, introduceTextView].forEach { contentView.addSubview($0) }
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
			$0.top.equalTo(contentView)
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

		peopleDiscriptionLabel.snp.makeConstraints {
			$0.top.equalTo(datePickerTextField.snp.bottom).offset(30)
			$0.horizontalEdges.equalTo(contentView).inset(20)
		}

		iosStepper.snp.makeConstraints {
			$0.top.equalTo(peopleDiscriptionLabel.snp.bottom).offset(20)
			$0.horizontalEdges.equalTo(contentView).inset(20)
		}

		backStepper.snp.makeConstraints {
			$0.top.equalTo(iosStepper.snp.bottom).offset(20)
			$0.horizontalEdges.equalTo(contentView).inset(20)
		}

		pmStepper.snp.makeConstraints {
			$0.top.equalTo(backStepper.snp.bottom).offset(20)
			$0.horizontalEdges.equalTo(contentView).inset(20)
		}

		uiuxStepper.snp.makeConstraints {
			$0.top.equalTo(pmStepper.snp.bottom).offset(20)
			$0.horizontalEdges.equalTo(contentView).inset(20)
		}


		introduceDiscriptionLabel.snp.makeConstraints {
			$0.top.equalTo(uiuxStepper.snp.bottom).offset(30)
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

		nextButton.setTitle("다음", for: .normal)
		nextButton.backgroundColor = .lightGray
		nextButton.layer.cornerRadius = 10

		defaultDiscriptionLabel.text = "기본 정보"
		defaultDiscriptionLabel.font = .boldSystemFont(ofSize: 20)

		titleTextField.placeholder = "제목"

		datePickerTextField.inputView = datePicker
		datePickerTextField.text = "\(Date())"
		datePickerTextField.placeholder = "마감일"
		datePickerTextField.delegate = self

		datePicker.minimumDate = Date()
		datePicker.datePickerMode = .date
		datePicker.preferredDatePickerStyle = .wheels

		peopleDiscriptionLabel.text = "인원"
		peopleDiscriptionLabel.font = .boldSystemFont(ofSize: 20)

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

	func configureUI(_ data: EventPost) {
		titleTextField.text = data.title
	}

	// Logic인거같은데..
	func getWritePostRequestModel(_ id: String) -> WritePostRequestModel {
		var content = ""
		var content3: Int = 0
		[iosStepper, backStepper, pmStepper, uiuxStepper].enumerated().forEach { index, item in
			if item.stepper.value != 0 {
				content += "#\(Job.allCases[index].rawValue);\(Int(item.stepper.value)) "
			}
			content3 += Int(item.stepper.value)
		}

		return WritePostRequestModel(product_id: id,
											  content: content,
											  content1: "\(DateFormatter.formatter.string(from: datePicker.date))",
											  content2: "\(DateFormatter.formatter.string(from: datePicker.date))",
											  content3: "\(content3)",
											  content4: introduceTextView.text,
											  content5: "",
											  title: titleTextField.text!)
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

extension PartyPostAddView: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if textField == datePickerTextField {
			return false
		} else {
			return true
		}
	}
}
