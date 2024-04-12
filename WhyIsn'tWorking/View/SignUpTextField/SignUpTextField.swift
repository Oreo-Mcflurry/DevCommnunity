//
//  SignUpTextField.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/11/24.
//

import Foundation
import TextFieldEffects

final class SignUpTextField: HoshiTextField {

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.borderInactiveColor = .gray
		self.borderActiveColor = .systemBlue
	}

	required init?(coder: NSCoder) {
		fatalError()
	}
}
