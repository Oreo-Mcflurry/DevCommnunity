//
//  PartyDetailViewStackCell.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/2/24.
//

import UIKit
import SnapKit

final class PartyDetailViewStackCell: BaseUIView {
	private let jobNameLabel = UILabel()
	private let jobImageView = UIImageView()
	private let maxPartyLabel = UILabel()

	override func configureHierarchy() {
		[jobNameLabel, jobImageView,  maxPartyLabel].forEach { addSubview($0) }
	}

	override func configureLayout() {
		jobNameLabel.snp.makeConstraints {
			$0.top.equalTo(self).offset(10)
			$0.horizontalEdges.equalTo(self).inset(10)
		}

		jobImageView.snp.makeConstraints {
			$0.top.equalTo(jobNameLabel.snp.bottom).offset(10)
			$0.horizontalEdges.equalTo(self).inset(10)
			$0.size.equalTo(150)
		}

		maxPartyLabel.snp.makeConstraints {
			$0.top.equalTo(jobImageView.snp.bottom).offset(10)
			$0.horizontalEdges.equalTo(self).inset(10)
		}
	}

	override func configureView() {
		jobNameLabel.font = .boldSystemFont(ofSize: 20)

		jobImageView.contentMode = .scaleAspectFit

		maxPartyLabel.textAlignment = .right
	}

	func configureUI(_ data: (job: String, maxParty: String)) {
		jobNameLabel.text = data.job
		maxPartyLabel.text = data.maxParty
	}
}
