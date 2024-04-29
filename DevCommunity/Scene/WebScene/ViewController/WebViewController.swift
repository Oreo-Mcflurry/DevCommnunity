//
//  WebViewController.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/29/24.
//

import UIKit
import SnapKit
import WebKit

final class WebViewController: BaseViewController {
	var url: URL!

	private let webView = WebView()

	override func loadView() {
		self.view = webView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureView() {
		let urlRequest = URLRequest(url: url)

		webView.web.load(urlRequest)
	}
}
