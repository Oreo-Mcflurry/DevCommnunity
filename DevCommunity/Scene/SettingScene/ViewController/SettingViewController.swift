//
//  SettingViewController.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/17/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingViewController: BaseViewController {
	private let viewModel = SettingViewModel()
	private let settingView = SettingView()
	private let disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}
