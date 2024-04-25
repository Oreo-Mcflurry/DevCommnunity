//
//  RxSwift+Extension.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/25/24.
//

import UIKit
import RxSwift

extension Reactive where Base: UIViewController {
	public var viewWillAppear: Observable<Void> {
		return methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in }
	}

	public var viewDidLoad: Observable<Void> {
		return methodInvoked(#selector(UIViewController.viewDidLoad)).map { _ in }
	}

	public var viewDidAppear: Observable<Void> {
		return methodInvoked(#selector(UIViewController.viewDidAppear)).map { _ in }
	}
}
