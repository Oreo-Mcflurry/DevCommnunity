//
//  TitleView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/25/24.
//

import UIKit
import SnapKit

class TitleView: BaseUIView {
	let imageView = UIImageView()
	let titleLabel = UILabel()

	override func configureHierarchy() {
		[imageView, titleLabel].forEach { addSubview($0) }
	}

	override func configureLayout() {
		<#code#>
	}
}
