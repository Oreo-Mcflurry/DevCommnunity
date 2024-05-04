//
//  SignUpTextField.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/11/24.
//

import Foundation
import TextFieldEffects

final class BaseTextField: HoshiTextField {

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.borderInactiveColor = .gray
		self.borderActiveColor = .accent
	}

	required init?(coder: NSCoder) {
		fatalError()
	}
}
