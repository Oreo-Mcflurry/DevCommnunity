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
	let addButton = UIButton()

	override func configureHierarchy() {
		[detailTableView, addButton].forEach { addSubview($0) }
	}

	override func configureLayout() {
		detailTableView.snp.makeConstraints {
			$0.edges.equalTo(self)
		}

		// 여기서 레이아웃이 깨지는 오류가 나는데,, 도저히 뭔지 모르겠습니다.. 날만한 이유가 전혀 없는거같은데..
		addButton.snp.makeConstraints {
			$0.bottom.equalTo(self).inset(50)
			$0.trailing.equalTo(self).inset(30)
			$0.size.equalTo(70)
			$0.top.greaterThanOrEqualTo(self)
			$0.leading.greaterThanOrEqualTo(self)
		}
	}

	override func configureView() {
		detailTableView.register(DetailHeaderView.self, forHeaderFooterViewReuseIdentifier: DetailHeaderView.identifier)
		detailTableView.register(PartyTableViewCell.self, forCellReuseIdentifier: PartyTableViewCell.identifier)
		detailTableView.register(PartyEmptyTableViewCell.self, forCellReuseIdentifier: PartyEmptyTableViewCell.identifier)
		detailTableView.contentInsetAdjustmentBehavior = .never
		detailTableView.sectionFooterHeight = 0
		detailTableView.backgroundColor = .white

		addButton.backgroundColor = .accent
		addButton.setImage(UIImage(systemName: "plus"), for: .normal)
		addButton.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .regular, scale: .default), forImageIn: .normal)
		addButton.tintColor = .white
		addButton.layer.cornerRadius = 35
	}
}
