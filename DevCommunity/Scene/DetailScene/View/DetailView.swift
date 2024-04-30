//
//  DetailView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/22/24.
//

import UIKit
import RxSwift
import SnapKit
import Kingfisher

final class DetailView: BaseUIView {
	let detailTableView = UITableView(frame: .zero, style: .grouped)
	private let detailTableHeaderView = DetailHeaderView()

	override func configureHierarchy() {
		[detailTableView].forEach { addSubview($0) }
	}

	override func configureLayout() {
		detailTableView.snp.makeConstraints {
			$0.edges.equalTo(self)
		}
	}

	override func configureView() {
		detailTableView.register(DetailHeaderView.self, forHeaderFooterViewReuseIdentifier: DetailHeaderView.identifier)
		detailTableView.register(PartyViewCell.self, forCellReuseIdentifier: PartyViewCell.identifier)
		detailTableView.contentInsetAdjustmentBehavior = .never
		detailTableView.sectionFooterHeight = 0
		detailTableView.backgroundColor = .white
	}

	func configureUI(_ data: EventPost) {
//		heroImageView.kf.setImage(with: data.imageURL)
//		organizerLabel.text = data.organizer
//		eventTitleLabel.text = data.title
//		timeLabel.text = data.time
//		likeLabel.text = data.likeString
	}

	func configureStackView(_ data: [PartyPost]) {
//		data.forEach {
//			let cell = PartyViewCell()
//			cell.configureUI($0)
//			partyCellView.append(cell)
//		}
//
//		partyCellView.forEach {
//			partyStackView.addArrangedSubview($0)
//		}
	}
}
