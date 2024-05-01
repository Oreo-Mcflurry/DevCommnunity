//
//  AuthRouter.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/30/24.
//

import Foundation
import Moya

// Moya + Interceptor로 관리하는 로직을 계획하고 있었는데, 도저히 공수가 맞지 않아서 일단 주말로 미뤘습니다. 다 완성하고 네트워크쪽 건드는걸로 계획을 다시 수정하는걸로 하겠습니다.

enum AuthRouter {
	case access
	case login(query: LoginRequestModel)
}


extension AuthRouter: TargetType {

	func asURLRequest() throws -> URLRequest {
		let url = try baseURL.asURL()
		var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)

		if let queryItems = queryItems {
			urlRequest.url?.append(queryItems: queryItems)
		}
		urlRequest.allHTTPHeaderFields = headers
		urlRequest.httpBody = parameters?.data(using: .utf8)
		urlRequest.httpBody = body
		return urlRequest
	}

	var path: String {
		switch self {
		case .access:
			return "v1/auth/refresh"
		case .login:
			return "v1/users/login"
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
		case .login:
			return [
				HTTPHeader.contentType.rawValue: HTTPHeader.json.rawValue,
				HTTPHeader.sesackey.rawValue: APIKey.sesacKey.rawValue
			]
		}
	}
	

	var task: Moya.Task {
		return .requestParameters(parameters: headers ?? [:], encoding: URLEncoding.default)
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
		}
	}

	var parameters: String? {
		return nil
	}

	var queryItems: [URLQueryItem]? {
		return nil
	}

	var body: Data? {
		switch self {
		case .access:
			return nil
		case .login(let data):
			return encoding(data: data)
		}
	}

	private func encoding(data: Encodable) -> Data? {
		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertToSnakeCase
		return try? encoder.encode(data)
	}
}
