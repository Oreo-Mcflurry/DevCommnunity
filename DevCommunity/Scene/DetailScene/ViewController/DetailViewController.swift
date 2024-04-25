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
	private let titleView = TitleView()
	private let disposeBag = DisposeBag()

	var eventPost = EventPost()
	private let dismissButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: DetailViewController.self, action: nil)
	private let heartButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: DetailViewController.self, action: nil)

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
		self.navigationItem.rightBarButtonItem = heartButton
		self.navigationItem.titleView = titleView

		titleView.configureUI(eventPost)
	}

	override func configureBinding() {
		let input = DetailViewModel.Input(inputOffset: detailView.scrollView.rx.contentOffset,
													 inputDismissButton: dismissButton.rx.tap,
													 inputHeartButton: heartButton.rx.tap,
													 inputViewDidAppear: self.rx.viewDidAppear)

		let output = viewModel.transform(input: input)

		output.outputHeroImageOpacity
			.drive(self.detailView.heroImageView.layer.rx.opacity)
			.disposed(by: disposeBag)

		output.outputHeroImageTransform
			.drive(self.detailView.heroImageView.rx.transform)
			.disposed(by: disposeBag)

		output.outputTitleViewIsHidden
			.drive(with: self) { owner, value in
				owner.navigationItem.titleView?.isHidden = value
			}.disposed(by: disposeBag)

		output.outputTitleViewOpacity
			.drive(with: self) { owner, value in
				owner.navigationItem.titleView?.layer.opacity = value
			}.disposed(by: disposeBag)

		output.outputDismissButton
			.drive(with: self) { owner, _ in
				owner.dismiss(animated: true)
			}.disposed(by: disposeBag)
	}
}
