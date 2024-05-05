//
//  PartyDetailView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/29/24.
//

import UIKit
import SnapKit

final class PartyDetailView: BaseUIView {
	private let scrollView = UIScrollView()
	private let contentView = UIView()

	private let bottomView = UIView()
	let bookmarkButton = UIButton()
	let joinButton = UIButton()

	private let titleLabel = UILabel()
	private let uploadDateLabel = UILabel()
	private let dDayLabel = UILabel()
	private let partyMaxLabel = UILabel()
	private let discriptionLabel = UILabel()
	private let recruitDiscriptionLabel = UILabel()
	private let recruitmentImageStackView = UIStackView()

	override func configureHierarchy() {
		[scrollView, bottomView].forEach { addSubview($0) }
		[bookmarkButton, joinButton].forEach { bottomView.addSubview($0) }
		[contentView].forEach { scrollView.addSubview($0) }
		[titleLabel, uploadDateLabel, dDayLabel, partyMaxLabel, discriptionLabel, recruitDiscriptionLabel, recruitmentImageStackView].forEach { contentView.addSubview($0) }
	}

	override func configureLayout() {
		scrollView.snp.makeConstraints {
			$0.edges.equalTo(self)
		}

		contentView.snp.makeConstraints {
			$0.width.equalTo(scrollView)
			$0.verticalEdges.equalTo(scrollView)
		}

		// Bottom
		bottomView.snp.makeConstraints {
			$0.bottom.equalTo(scrollView.snp.bottom)
			$0.horizontalEdges.equalTo(scrollView)
			$0.height.equalTo(100)
		}

		bookmarkButton.snp.makeConstraints {
			$0.top.leading.equalTo(bottomView).inset(20)
			$0.bottom.equalTo(bottomView).inset(30)
			$0.width.equalTo(bookmarkButton.snp.height)
		}

		joinButton.snp.makeConstraints {
			$0.top.trailing.equalTo(bottomView).inset(20)
			$0.bottom.equalTo(bottomView).inset(30)
			$0.leading.equalTo(bookmarkButton.snp.trailing).offset(20)
		}

		// Main
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
			$0.top.equalTo(recruitDiscriptionLabel.snp.bottom).offset(10)
			$0.leading.equalTo(contentView).offset(20)
			$0.trailing.lessThanOrEqualTo(contentView).inset(20)
			$0.bottom.equalTo(contentView).inset(20)
		}
	}

	override func configureView() {
		scrollView.alwaysBounceVertical = true

		bottomView.layer.borderColor = UIColor.lightGray.cgColor
		bottomView.layer.borderWidth = 1

		bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
		bookmarkButton.setPreferredSymbolConfiguration(.init(pointSize: 25, weight: .regular, scale: .default), forImageIn: .normal)

		joinButton.setTitle("참가신청", for: .normal)
		joinButton.backgroundColor = .accent
		joinButton.layer.cornerRadius = 10

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
				$0.width.lessThanOrEqualTo(140)
			}
			recruitmentImageStackView.addArrangedSubview(cell)
		}
	}
}
