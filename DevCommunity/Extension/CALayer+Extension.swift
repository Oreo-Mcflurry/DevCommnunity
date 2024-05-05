//
//  CALayer+Extension.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/5/24.
//

import UIKit

extension CALayer {
	func addBorder(_ edges: [UIRectEdge], color: UIColor, width: CGFloat) {

		for edge in edges {
			let border = CALayer()
			switch edge {
			case .top:
				border.frame = CGRect(x: 0, y: 0, width: frame.width, height: width)
			case .bottom:
				border.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: width)
			case .left:
				border.frame = CGRect(x: 0, y: 0, width: width, height: frame.height)
			case .right:
				border.frame = CGRect(x: frame.width - width, y: 0, width: width, height: frame.height)
			default:
				break
			}
			border.backgroundColor = color.cgColor
			self.addSublayer(border)
		}
	}
}

extension CALayer {
	func removeAllBorders() {
		sublayers?.popLast()
	}
}
