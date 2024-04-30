//
//  PartyTableViewCell.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/26/24.
//

import UIKit
import SnapKit

final class PartyViewCell: BaseTableViewCell {
	var data = PartyPost()
	
	private let dDayLabel = UILabel()
	private let partyMaxLabel = UILabel()
	private let titleLabel = UILabel()
	private let bookmarkButton = UIButton()
	private let discriptionLabel = UILabel()
	private let recruitMentsStackView = UIStackView()

	override func configureHierarchy() {
		[dDayLabel, partyMaxLabel, titleLabel, bookmarkButton, discriptionLabel, recruitMentsStackView].forEach { self.contentView.addSubview($0) }
	}

	override func configureLayout() {
		dDayLabel.snp.makeConstraints {
			$0.top.equalTo(contentView).inset(10)
			$0.leading.equalTo(contentView).inset(20)
		}

		partyMaxLabel.snp.makeConstraints {
			$0.top.equalTo(contentView).inset(10)
			$0.leading.equalTo(dDayLabel.snp.trailing).offset(20)
		}

		bookmarkButton.snp.makeConstraints {
			$0.top.equalTo(contentView).inset(10)
			$0.leading.greaterThanOrEqualTo(partyMaxLabel.snp.trailing).offset(10)
			$0.size.equalTo(30)
			$0.trailing.equalTo(contentView).inset(20)
		}

		titleLabel.snp.makeConstraints  {
			$0.top.equalTo(bookmarkButton.snp.bottom).offset(10)
			$0.horizontalEdges.equalTo(contentView).inset(20)
		}

		discriptionLabel.snp.makeConstraints {
			$0.top.equalTo(titleLabel.snp.bottom).offset(10)
			$0.horizontalEdges.equalTo(contentView).inset(20)
		}

		recruitMentsStackView.snp.makeConstraints {
			$0.top.equalTo(discriptionLabel.snp.bottom).offset(10)
			$0.leading.equalTo(contentView).inset(20)
			$0.trailing.lessThanOrEqualTo(contentView).inset(20)
			$0.bottom.equalTo(contentView).inset(10)
		}
	}

	override func configureView() {
		dDayLabel.textColor = .blue
		partyMaxLabel.textColor = .lightGray
		bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
		discriptionLabel.numberOfLines = 3

		titleLabel.font = .preferredFont(forTextStyle: .title3)

		recruitMentsStackView.alignment = .leading
		recruitMentsStackView.distribution = .equalSpacing
		recruitMentsStackView.spacing = 10
	}

	func configureUI(_ data: PartyPost) {
		self.data = data

		dDayLabel.text = data.dDay
		partyMaxLabel.text = data.maxPeople
		titleLabel.text = data.title
		bookmarkButton.setImage(data.isBookmarked ? UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark"), for: .normal)
		discriptionLabel.text = data.mainText

		data.hashTagString.forEach {
			let basePaddingLabel = BasePaddingLabel(padding: 6)

			basePaddingLabel.text = $0
			recruitMentsStackView.addArrangedSubview(basePaddingLabel)
		}
	}
}
