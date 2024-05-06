//
//  PayRouter.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/6/24.
//

import Foundation
import Moya

enum PayRouter {
	case payValidation(query: PayValidationModel)
}

extension PayRouter: TargetType {
	var baseURL: URL {
		return URL(string: APIKey.baseURL.rawValue)!
	}

	var path: String {
		return "v1/payments/validation"
	}

	var method: Moya.Method {
		return .post
	}

	var task: Moya.Task {
		switch self {
		case .payValidation(let query):
			return .requestJSONEncodable(query)
		}
	}

	var headers: [String : String]? {
		return [
			HTTPHeader.authorization.rawValue: UserDefaults.standard[.accessToken],
			HTTPHeader.sesackey.rawValue: APIKey.sesacKey.rawValue
		]
	}
}
