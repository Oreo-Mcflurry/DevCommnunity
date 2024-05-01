//
//  PartyEmptyTableViewCell.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/30/24.
//

import UIKit
import SnapKit

final class PartyEmptyTableViewCell: BaseTableViewCell {
	private let emptyMainLabel = UILabel()
	private let emptyImage = UIImageView()
	private let emptySubLabel = UILabel()

	override func configureHierarchy() {
		[emptyMainLabel, emptyImage, emptySubLabel].forEach { contentView.addSubview($0) }
	}

	override func configureLayout() {
		emptyMainLabel.snp.makeConstraints {
			$0.horizontalEdges.equalTo(contentView).inset(20)
			$0.width.equalTo(150)
		}

		emptyImage.snp.makeConstraints {
			$0.top.equalTo(emptyMainLabel.snp.bottom).offset(10)
			$0.centerX.equalTo(contentView)
			$0.size.equalTo(50)
		}

		emptySubLabel.snp.makeConstraints {
			$0.top.equalTo(emptyImage.snp.bottom).offset(10)
			$0.horizontalEdges.equalTo(contentView).inset(20)
			$0.bottom.equalTo(contentView)
		}
	}

	override func configureView() {
		emptyMainLabel.text = "이런!"
		emptyMainLabel.textAlignment = .center
		emptyMainLabel.font = .boldSystemFont(ofSize: 25)

		emptyImage.image = UIImage(systemName: "star")

		emptySubLabel.text = "모집글이 없네요!\n모집글을 작성해서 팀원을 구해보세요!"
		emptySubLabel.textColor = .gray
	}
}
