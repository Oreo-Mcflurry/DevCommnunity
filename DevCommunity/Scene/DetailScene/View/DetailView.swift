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
		detailTableView.register(PartyTableViewCell.self, forCellReuseIdentifier: PartyTableViewCell.identifier)
		detailTableView.register(PartyEmptyTableViewCell.self, forCellReuseIdentifier: PartyEmptyTableViewCell.identifier)
		detailTableView.contentInsetAdjustmentBehavior = .never
		detailTableView.sectionFooterHeight = 0
		detailTableView.backgroundColor = .white
	}
}
