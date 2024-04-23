//
//  EventsTableViewCell.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/19/24.
//

import UIKit
import SnapKit
import SkeletonView
import Kingfisher

final class EventsTableViewCell: BaseTableViewCell {
	private let eventsImageView = UIImageView()
	private let organizerLabel = UILabel()
	private let eventTitleLabel = UILabel()
	private let dDayLabel = BasePaddingLabel(padding: 6)
	private let timeLabel = UILabel()
	private let hashTagsLabel = UILabel()

	override func configureHierarchy() {
		[eventsImageView, organizerLabel, eventTitleLabel, dDayLabel, timeLabel, hashTagsLabel].forEach { contentView.addSubview($0) }
	}

	override func configureLayout() {
		eventsImageView.snp.makeConstraints {
			$0.top.horizontalEdges.equalTo(self.contentView).inset(10)
			$0.height.equalTo(eventsImageView.snp.width).dividedBy(1.618)
		}

		organizerLabel.snp.makeConstraints {
			$0.top.equalTo(eventsImageView.snp.bottom).offset(10)
			$0.horizontalEdges.equalTo(self.contentView).inset(20)
		}

		eventTitleLabel.snp.makeConstraints {
			$0.top.equalTo(organizerLabel.snp.bottom).offset(10)
			$0.leading.equalTo(self.contentView).inset(20)
		}

		eventTitleLabel.setContentCompressionResistancePriority(.init(750), for: .horizontal)

		dDayLabel.snp.makeConstraints {
			$0.top.greaterThanOrEqualTo(eventTitleLabel)
			$0.bottom.equalTo(eventTitleLabel.snp.lastBaseline)
			$0.leading.equalTo(eventTitleLabel.snp.trailing).offset(10)
			$0.trailing.lessThanOrEqualTo(self.contentView).inset(20)
		}

		dDayLabel.setContentCompressionResistancePriority(.init(751), for: .horizontal)

		timeLabel.snp.makeConstraints {
			$0.top.equalTo(eventTitleLabel.snp.bottom).offset(10)
			$0.horizontalEdges.equalTo(self.contentView).inset(20)
		}

		hashTagsLabel.snp.makeConstraints {
			$0.top.equalTo(timeLabel.snp.bottom).offset(10)
			$0.horizontalEdges.equalTo(self.contentView).inset(20)
			$0.bottom.equalTo(self.contentView).inset(20)
		}
	}

	override func configureView() {
		[self, self.contentView, eventsImageView, organizerLabel, eventTitleLabel, dDayLabel, timeLabel, hashTagsLabel].forEach {
			$0.isSkeletonable = true
		}
	}

	func configureSkeleton() {
		self.showAnimatedSkeleton()
	}

	func configureCell(_ data: EventPost) {
		self.hideSkeleton()
		KingfisherManager.shared.setHeaders()
		eventsImageView.kf.setImage(with: data.imageURL)

		organizerLabel.text = data.organizer
		organizerLabel.font = .preferredFont(forTextStyle: .title3)

		eventTitleLabel.text = data.title
		eventTitleLabel.font = .preferredFont(forTextStyle: .title3)
		eventTitleLabel.numberOfLines = 2

		dDayLabel.text = data.dDay

		timeLabel.text = data.time
		timeLabel.textColor = .lightGray

		hashTagsLabel.text = data.hashTags
		hashTagsLabel.textColor = .lightGray
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		self.hideSkeleton()
	}
}
