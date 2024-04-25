//
//  TitleView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/25/24.
//

import UIKit
import SnapKit
import Kingfisher

class TitleView: BaseUIView {
	private let imageView = UIImageView()
	private let titleLabel = UILabel()

	override func configureHierarchy() {
		[imageView, titleLabel].forEach { addSubview($0) }
	}

	override func configureLayout() {
		imageView.snp.makeConstraints {
			$0.leading.equalTo(self).offset(20)
			$0.verticalEdges.equalTo(self).inset(10)
			$0.height.equalTo(imageView.snp.width)
		}

		titleLabel.snp.makeConstraints {
			$0.leading.equalTo(imageView.snp.trailing).offset(10)
			$0.verticalEdges.equalTo(self).inset(10)
			$0.trailing.equalTo(self).inset(20)
		}
	}

	func configureUI(_ data: EventPost) {
		imageView.kf.setImage(with: data.imageURL)
		titleLabel.text = data.title
	}
}
