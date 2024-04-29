//
//  WebView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/29/24.
//

import UIKit
import SnapKit
import WebKit

final class WebView: BaseUIView {
	let web = WKWebView()

	override func configureHierarchy() {
		[web].forEach { addSubview($0) }
	}

	override func configureLayout() {
		web.snp.makeConstraints {
			$0.edges.equalTo(self)
		}
	}
}
