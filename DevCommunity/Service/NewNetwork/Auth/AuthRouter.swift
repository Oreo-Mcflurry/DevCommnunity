//
//  AuthRouter.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/30/24.
//

import Foundation
import Moya

enum AuthRouter {
	case access
	case login(query: LoginRequestModel)
	case withDraw
	case signUp(data: SignUpRequetModel)
}


extension AuthRouter: TargetType {

	var path: String {
		switch self {
		case .access:
			return "v1/auth/refresh"
		case .login:
			return "v1/users/login"
		case .withDraw:
			return "v1/users/withdraw"
		case .signUp:
			return "v1/users/join"
		}
	}
	
	var headers: [String : String]? {
		switch self {
		case .access:
			return [
				HTTPHeader.refresh.rawValue: UserDefaults.standard[.refreshToken],
				HTTPHeader.sesackey.rawValue: APIKey.sesacKey.rawValue,
				HTTPHeader.authorization.rawValue: UserDefaults.standard[.accessToken]
			]
		case .login, .signUp:
			return [
				HTTPHeader.contentType.rawValue: HTTPHeader.json.rawValue,
				HTTPHeader.sesackey.rawValue: APIKey.sesacKey.rawValue
			]
		case .withDraw:
			return [
				HTTPHeader.sesackey.rawValue: APIKey.sesacKey.rawValue,
				HTTPHeader.authorization.rawValue: UserDefaults.standard[.accessToken]
			]
		}
	}
	

	var task: Moya.Task {
		switch self {
		case .access:
			return .requestParameters(parameters: headers ?? [:], encoding: URLEncoding.default)
		case .login(let query):
			return .requestJSONEncodable(query)
		case .withDraw:
			return .requestParameters(parameters: headers ?? [:], encoding: URLEncoding.default)
		case .signUp(let data):
			return .requestJSONEncodable(data)
		}
	}

	var baseURL: URL {
		return URL(string: APIKey.baseURL.rawValue)!
	}

	var method: Moya.Method {
		switch self {
		case .access:
			return .get
		case .login:
			return .post
		case .withDraw:
			return .get
		case .signUp:
			return .post
		}
	}
}
