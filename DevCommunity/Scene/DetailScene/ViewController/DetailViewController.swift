//
//  DetailViewController.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/22/24.
//

import UIKit
import RxSwift
import RxCocoa
import SkeletonView

final class DetailViewController: BaseViewController {
	private let viewModel = DetailViewModel()
	private let detailView = DetailView()
	private let disposeBag = DisposeBag()

	var eventPost = EventPost()
	private let dismissButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: DetailViewController.self, action: nil)

	override func loadView() {
		self.view = detailView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureView() {
		self.tabBarController?.tabBar.isHidden = true
		detailView.configureUI(eventPost)
		self.navigationItem.leftBarButtonItem = dismissButton
	}
	override func configureBinding() {
		//		dismissButton.rx.tap.bind(with: self) { owner, _ in
		//			print("RRR")
		//		}

		detailView.scrollView.rx.contentOffset
			.bind(with: self) { owner, value in
				let scaleFactor = max(0, -value.y) / 100

				owner.detailView.heroImageView.transform = CGAffineTransform(scaleX: 1 + scaleFactor, y: 1 + scaleFactor)
			}.disposed(by: disposeBag)
	}
}
