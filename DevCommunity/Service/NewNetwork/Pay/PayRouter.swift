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
	case isUserBought
}

extension PayRouter: TargetType {
	var baseURL: URL {
		return URL(string: APIKey.baseURL.rawValue)!
	}

	var path: String {
		switch self {
		case .payValidation:
			return "v1/payments/validation"
		case .isUserBought:
			return "v1/payments/me"
		}
	}

	var method: Moya.Method {
		switch self {
		case .payValidation:
			return .post
		case .isUserBought:
			return .get
		}
	}

	var task: Moya.Task {
		switch self {
		case .payValidation(let query):
			return .requestJSONEncodable(query)
		case .isUserBought:
			return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
		}
	}

	var headers: [String : String]? {
		return [
			HTTPHeader.authorization.rawValue: UserDefaults.standard[.accessToken],
			HTTPHeader.sesackey.rawValue: APIKey.sesacKey.rawValue
		]
	}
}
