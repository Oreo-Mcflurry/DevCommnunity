//
//  PartyPostAddView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/1/24.
//

import UIKit
import SnapKit

final class PartyPostAddView: BaseUIView {
	private let scrollView = UIScrollView()
	private let contentView = UIView()

	private let defaultDiscriptionLabel = UILabel()
	private let titleTextField = BaseTextField()
	private let introduceTextEditer = UITextView()

	override func configureHierarchy() {
		[scrollView].forEach { addSubview($0) }
		[contentView].forEach { scrollView.addSubview($0) }

	}

	override func configureLayout() {
		scrollView.snp.makeConstraints {
			$0.edges.equalTo(self)
		}

		contentView.snp.makeConstraints {
			$0.verticalEdges.equalTo(scrollView)
			$0.width.equalTo(scrollView)
		}
	}

	override func configureView() {

	}
}
