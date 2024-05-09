//
//  PartyDetailView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/29/24.
//

import UIKit
import SnapKit

final class PartyDetailView: BaseUIView {
	let partyTableView = UITableView(frame: .zero, style: .grouped)

	private let bottomView = UIView()
	let bookmarkButton = UIButton()
	let joinButton = UIButton()

	override func configureHierarchy() {
		[partyTableView, bottomView].forEach { addSubview($0) }
		[bookmarkButton, joinButton].forEach { bottomView.addSubview($0) }
	}

	override func configureLayout() {
		partyTableView.snp.makeConstraints {
			$0.edges.equalTo(self)
		}

		bottomView.snp.makeConstraints {
			$0.bottom.equalTo(partyTableView.snp.bottom)
			$0.horizontalEdges.equalTo(partyTableView)
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
	}

	override func configureView() {
		partyTableView.sectionFooterHeight = 0
		partyTableView.backgroundColor = .white
		partyTableView.allowsSelection = false
		partyTableView.separatorStyle = .none

		bottomView.layer.borderColor = UIColor.lightGray.cgColor
		bottomView.layer.borderWidth = 1

		bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
		bookmarkButton.setPreferredSymbolConfiguration(.init(pointSize: 25, weight: .regular, scale: .default), forImageIn: .normal)

		joinButton.setTitle("참가신청", for: .normal)
		joinButton.backgroundColor = .accent
		joinButton.layer.cornerRadius = 10

		partyTableView.register(PartyDetailHeaderView.self, forHeaderFooterViewReuseIdentifier: PartyDetailHeaderView.identifier)
		partyTableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.identifier)
		partyTableView.register(AppliedTableViewCell.self, forCellReuseIdentifier: AppliedTableViewCell.identifier)
	}
}
