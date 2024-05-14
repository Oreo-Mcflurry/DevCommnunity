//
//  KingFisher+Extension.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/20/24.
//

import Foundation
import Kingfisher

extension KingfisherManager {
	func setHeaders() {
		let modifier = AnyModifier { request in
			var req = request
			req.addValue(UserDefaults.standard[.accessToken], forHTTPHeaderField: HTTPHeader.authorization.rawValue)
			req.addValue(APIKey.sesacKey.rawValue, forHTTPHeaderField: HTTPHeader.sesackey.rawValue)
			req.addValue(HTTPHeader.json.rawValue, forHTTPHeaderField: HTTPHeader.contentType.rawValue)
			return req
		}

		KingfisherManager.shared.defaultOptions = [
			.requestModifier(modifier)
		]
	}
}
