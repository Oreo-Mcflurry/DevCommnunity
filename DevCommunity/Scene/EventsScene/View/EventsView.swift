//
//  HomeVIew.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/15/24.
//

import UIKit
import SnapKit

final class EventsView: BaseUIView {

	lazy var eventTableView = UITableView()
	let refreshControl = UIRefreshControl()

	override func configureHierarchy() {
		[eventTableView].forEach { addSubview($0) }
	}

	override func configureLayout() {
		eventTableView.snp.makeConstraints {
			$0.edges.equalTo(self)
		}
	}

	override func configureView() {
		eventTableView.register(EventsTableViewCell.self, forCellReuseIdentifier: EventsTableViewCell.description())
		eventTableView.refreshControl = refreshControl
		eventTableView.rowHeight = UITableView.automaticDimension
	}
}
