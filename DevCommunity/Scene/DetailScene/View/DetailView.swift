//
//  DetailView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/22/24.
//

import UIKit
import RxSwift

final class DetailView: BaseUIView {
	private let heroImageView = UIImageView()
	private let roundedView = UIView()
	private let titleLabel = UILabel()

	override func configureHierarchy() {
		[heroImageView, roundedView, titleLabel].forEach { addSubview($0) }
	}

	override func configureLayout() {
		
	}

	override func configureView() {

	}
}
