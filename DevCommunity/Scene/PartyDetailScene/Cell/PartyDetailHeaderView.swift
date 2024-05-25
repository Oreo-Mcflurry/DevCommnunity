//
//  PartyDetailHeaderView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/7/24.
//

import UIKit
import SnapKit

final class PartyDetailHeaderView: BaseTableHeaderView {
	private let titleLabel = UILabel()
	private let uploadDateLabel = UILabel()
	private let dDayLabel = UILabel()
	private let partyMaxLabel = UILabel()
	private let discriptionLabel = UILabel()
	private let recruitDiscriptionLabel = UILabel()
	private let recruitmentImageStackView = UIStackView()
	private let appliedDiscriptionLabel = UILabel()

	override func configureHierarchy() {
		[titleLabel, uploadDateLabel, dDayLabel, partyMaxLabel, discriptionLabel, recruitDiscriptionLabel, recruitmentImageStackView, appliedDiscriptionLabel].forEach { contentView.addSubview($0) }
	}

	override func configureLayout() {
		titleLabel.snp.makeConstraints {
			$0.top.equalTo(contentView)
			$0.horizontalEdges.equalTo(contentView).inset(20)
		}

		uploadDateLabel.snp.makeConstraints {
			$0.top.equalTo(titleLabel.snp.bottom).offset(10)
			$0.leading.equalTo(contentView).inset(20)
		}

		dDayLabel.snp.makeConstraints {
			$0.top.equalTo(titleLabel.snp.bottom).offset(10)
			$0.leading.equalTo(uploadDateLabel.snp.trailing).offset(10)
			$0.trailing.lessThanOrEqualTo(contentView).inset(20)
		}

		discriptionLabel.snp.makeConstraints {
			$0.top.equalTo(dDayLabel.snp.bottom).offset(20)
			$0.horizontalEdges.equalTo(contentView).inset(20)
		}

		recruitDiscriptionLabel.snp.makeConstraints {
			$0.top.equalTo(discriptionLabel.snp.bottom).offset(30)
			$0.horizontalEdges.equalTo(contentView).inset(20)
		}

		recruitmentImageStackView.snp.makeConstraints {
			$0.top.equalTo(recruitDiscriptionLabel.snp.bottom).offset(20)
			$0.leading.equalTo(contentView).offset(20)
			$0.trailing.lessThanOrEqualTo(contentView).inset(20)
			$0.height.equalTo(100)
		}

		appliedDiscriptionLabel.snp.makeConstraints {
			$0.top.equalTo(recruitmentImageStackView.snp.bottom).offset(20)
			$0.horizontalEdges.equalTo(contentView).inset(20)
			$0.bottom.equalTo(contentView)
		}
	}

	override func configureView() {
		titleLabel.numberOfLines = 2
		titleLabel.font = .boldSystemFont(ofSize: 20)

		dDayLabel.font = .preferredFont(forTextStyle: .callout)
		dDayLabel.textColor = .lightGray

		uploadDateLabel.font = .preferredFont(forTextStyle: .callout)
		uploadDateLabel.textColor = .lightGray

		discriptionLabel.numberOfLines = 0

		recruitDiscriptionLabel.text = "모집 중"
		recruitDiscriptionLabel.font = .boldSystemFont(ofSize: 20)

		recruitmentImageStackView.axis = .horizontal
		recruitmentImageStackView.spacing = 10
		recruitmentImageStackView.alignment = .leading
		recruitmentImageStackView.distribution = .fillEqually

		appliedDiscriptionLabel.text = "지원 현황"
		appliedDiscriptionLabel.font = .boldSystemFont(ofSize: 20)
	}

	func configureUI(_ data: PartyPost) {
		dDayLabel.text = data.dDay
		partyMaxLabel.text = data.partyMax
		titleLabel.text = data.title
		discriptionLabel.text = data.discriptionText
		uploadDateLabel.text = data.createDate

		data.recruitmentTuple.forEach {
			let cell = PartyDetailViewStackCell()
			cell.configureUI($0)

			cell.snp.makeConstraints {
				$0.size.lessThanOrEqualTo(100)
			}
			recruitmentImageStackView.addArrangedSubview(cell)
		}
	}
}
