//
//  HomeViewController.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/15/24.
//

import UIKit
import RxSwift
import RxCocoa

final class EventsViewController: BaseViewController {
	private let viewModel = EventsViewModel()
	private let homeView = EventsView()

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureBinding() {

	}
}
