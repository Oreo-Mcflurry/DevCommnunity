//
//  CheckBoxView.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/13/24.
//

import UIKit
import SnapKit

final class CheckBoxView: BaseUIView {
	let checkBoxImageButton = UIButton()
	let label = UILabel()
	private var isChecked = false

	enum CheckState: String {
		case check = "checkmark.square.fill"
		case none = "checkmark.square"
	}

	override func configureHierarchy() {
		[checkBoxImageButton, label].forEach { addSubview($0) }
	}
	
	override func configureLayout() {
		checkBoxImageButton.snp.makeConstraints {
			$0.width.equalTo(40)
			$0.height.equalTo(35)
			$0.verticalEdges.leading.equalTo(self)
		}

		label.snp.makeConstraints {
			$0.verticalEdges.trailing.equalTo(self)
			$0.leading.equalTo(checkBoxImageButton.snp.trailing).offset(20)
		}
	}

	override func configureView() {
		checkBoxImageButton.setImage(UIImage(systemName: CheckState.none.rawValue), for: .normal)
		checkBoxImageButton.contentVerticalAlignment = .fill
		checkBoxImageButton.contentHorizontalAlignment = .fill
		checkBoxImageButton.tintColor = .black

		label.font = .boldSystemFont(ofSize: 18)
	}

	@discardableResult
	func toggle() -> Bool {
		isChecked.toggle()
		checkBoxImageButton.setImage(UIImage(systemName: isChecked ? CheckState.check.rawValue : CheckState.none.rawValue), for: .normal)
		return isChecked
	}
}
