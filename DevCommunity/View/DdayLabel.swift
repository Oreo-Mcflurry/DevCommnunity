//
//  DdayLabel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/22/24.
//

import UIKit

class BasePaddingLabel: UILabel {
	private var padding = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)

	convenience init(padding: CGFloat) {
		self.init()
		self.padding = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		self.layer.cornerRadius = 15
		self.clipsToBounds = true
		self.textColor = .gray
		self.backgroundColor = .systemGray6
	}

	override func drawText(in rect: CGRect) {
		super.drawText(in: rect.inset(by: padding))
	}

	override var intrinsicContentSize: CGSize {
		var contentSize = super.intrinsicContentSize
		contentSize.height += padding.top + padding.bottom
		contentSize.width += padding.left + padding.right

		return contentSize
	}
}
