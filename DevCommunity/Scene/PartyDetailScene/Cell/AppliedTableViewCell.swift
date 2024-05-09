//
//  AppliedTableViewCell.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/9/24.
//

import UIKit
import SnapKit

final class AppliedTableViewCell: BaseTableViewCell {
	private let nickNameLabel = UILabel()
	private let jobLabel = BasePaddingLabel(padding: 7)
	private let introduceLabel = UILabel()

	override func configureHierarchy() {
		[nickNameLabel, jobLabel, introduceLabel].forEach { contentView.addSubview($0) }
	}

	override func configureLayout() {
		nickNameLabel.snp.makeConstraints {
			$0.top.equalTo(contentView).offset(10)
			$0.leading.equalTo(contentView).inset(20)
		}

		jobLabel.snp.makeConstraints {
			$0.top.equalTo(contentView).offset(10)
			$0.leading.equalTo(nickNameLabel.snp.trailing).offset(10)
			$0.trailing.lessThanOrEqualTo(contentView).inset(20)
		}

		introduceLabel.snp.makeConstraints {
			$0.top.equalTo(jobLabel.snp.bottom).offset(10)
			$0.horizontalEdges.equalTo(contentView).inset(20)
			$0.bottom.equalTo(contentView).inset(10)
		}
	}

	override func configureView() {
		nickNameLabel.font = .boldSystemFont(ofSize: 17)
		introduceLabel.numberOfLines = 3
	}

	func configureUI(_ data: AppliedInfo) {
		nickNameLabel.text = data.joinNickName
		jobLabel.text = data.job
		introduceLabel.text = data.introduce
	}
}
