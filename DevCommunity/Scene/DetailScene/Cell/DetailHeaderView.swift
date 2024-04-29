//
//  DetailHeaderview.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/29/24.
//

import UIKit
import SnapKit
import Kingfisher

final class DetailHeaderView: BaseTableHeaderView {
	let heroImageView = UIImageView()
	private let roundedView = UIView()
	private let defendHeroView = UIView()
	private let organizerLabel = UILabel()
	private let eventTitleLabel = UILabel()
	private let timeLabel = UILabel()
	private let likeLabel = UILabel()
	private let partyDiscriptionLabel = UILabel()

	override func configureHierarchy() {
		[heroImageView, roundedView, defendHeroView, organizerLabel, eventTitleLabel, timeLabel, likeLabel, partyDiscriptionLabel].forEach { contentView.addSubview($0) }
	}

	override func configureLayout() {
		heroImageView.snp.makeConstraints {
			$0.top.horizontalEdges.equalTo(contentView)
			$0.height.equalTo(heroImageView.snp.width).dividedBy(1.618)
		}

		roundedView.snp.makeConstraints {
			$0.bottom.equalTo(heroImageView)
			$0.horizontalEdges.equalTo(contentView)
			$0.height.equalTo(20)
		}

		defendHeroView.snp.makeConstraints {
			$0.top.equalTo(roundedView.snp.bottom)
			$0.horizontalEdges.bottom.equalTo(contentView)
		}

		organizerLabel.snp.makeConstraints {
			$0.top.equalTo(roundedView.snp.bottom)
			$0.horizontalEdges.equalTo(contentView).inset(20)
		}

		eventTitleLabel.snp.makeConstraints {
			$0.top.equalTo(organizerLabel.snp.bottom).offset(10)
			$0.horizontalEdges.equalTo(contentView).inset(20)
		}

		timeLabel.snp.makeConstraints {
			$0.top.equalTo(eventTitleLabel.snp.bottom).offset(10)
			$0.horizontalEdges.equalTo(contentView).inset(20)
		}

		likeLabel.snp.makeConstraints {
			$0.top.equalTo(timeLabel.snp.bottom).offset(10)
			$0.horizontalEdges.equalTo(contentView).inset(20)
		}

		partyDiscriptionLabel.snp.makeConstraints {
			$0.top.equalTo(likeLabel.snp.bottom).offset(30)
			$0.horizontalEdges.equalTo(contentView).inset(20)
		}
	}

	override func configureView() {
		roundedView.backgroundColor = .white
		roundedView.clipsToBounds = true
		roundedView.layer.cornerRadius = 10
		roundedView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
		roundedView.layer.shadowColor = UIColor.black.cgColor
		roundedView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
		roundedView.layer.shadowRadius = 10

		defendHeroView.backgroundColor = .white

		organizerLabel.font = .preferredFont(forTextStyle: .callout)

		eventTitleLabel.font = .preferredFont(forTextStyle: .title3)
		eventTitleLabel.numberOfLines = 2

		timeLabel.textColor = .lightGray

		likeLabel.textColor = .lightGray

		partyDiscriptionLabel.text = "팀원 구합니다"
		partyDiscriptionLabel.font = .boldSystemFont(ofSize: 20)
	}

	func configureUI(_ data: EventPost) {
		heroImageView.kf.setImage(with: data.imageURL)
		organizerLabel.text = data.organizer
		eventTitleLabel.text = data.title
		timeLabel.text = data.time
		likeLabel.text = data.likeString
	}
}
