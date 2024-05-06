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
	var url: URL

	init(url: URL) {
		self.url = url
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
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
