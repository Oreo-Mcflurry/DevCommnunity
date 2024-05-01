//
//  PartyDetailView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/29/24.
//

import UIKit
import SnapKit

final class PartyDetailView: BaseUIView {
	private let dDayLabel = UILabel()
	private let partyMaxLabel = UILabel()
	private let titleLabel = UILabel()
	private let discriptionLabel = UILabel()
	private let uploadDateLabel = UILabel()
	private let recruitmentImageStackView = UIStackView()

	override func configureHierarchy() {
		[dDayLabel, partyMaxLabel, titleLabel, discriptionLabel, uploadDateLabel, recruitmentImageStackView].forEach { addSubview($0) }
	}

	override func configureLayout() {

	}

	override func configureView() {
		
	}

	func configureUI(_ data: PartyPost) {
		dDayLabel.text = data.dDay
		partyMaxLabel.text = data.partyMax
		titleLabel.text = data.title
		discriptionLabel.text = data.discriptionText
		uploadDateLabel.text = data.createDate
	}
}
