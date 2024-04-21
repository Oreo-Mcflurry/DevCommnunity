//
//  LoginRouter.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/13/24.
//

import Foundation
import Alamofire

enum Router {
	case access
	case login(query: LoginRequestModel)
	case getPost(query: PostsRequestModel)
	case signUp(data: SignUpRequetModel)
}

extension Router: TargetType {

	func asURLRequest() throws -> URLRequest {
		let url = try baseURL.asURL()
		var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)

		if let queryItems = queryItems {
			urlRequest.url?.append(queryItems: queryItems)
		}
		urlRequest.allHTTPHeaderFields = header
		urlRequest.httpBody = parameters?.data(using: .utf8)
		urlRequest.httpBody = body
		return urlRequest
	}

	var baseURL: String {
		return APIKey.baseURL.rawValue
	}

	var method: Alamofire.HTTPMethod {
		switch self {
		case .access:
			return .get
		case .login:
			return .post
		case .getPost:
			return .get
		case .signUp:
			return .post
		}
	}

	var header: [String : String] {
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
		case .getPost:
			return [
				HTTPHeader.authorization.rawValue: UserDefaults.standard[.accessToken],
				HTTPHeader.sesackey.rawValue: APIKey.sesacKey.rawValue
			]
		}
	}

	var path: String {
		switch self {
		case .access:
			return "v1/auth/refresh"
		case .login:
			return "v1/users/login"
		case .getPost:
			return "v1/posts"
		case .signUp:
			return "v1/users/join"
		}
	}

	var parameters: String? {
		return nil
	}
	
	var queryItems: [URLQueryItem]? {
		switch self {
		case .getPost(let query):
			return query.queryItems
		default:
			return nil
		}
	}
	
	var body: Data? {
		switch self {
		case .access:
			return nil
		case .login(let query):
			let encoder = JSONEncoder()
			encoder.keyEncodingStrategy = .convertToSnakeCase
			return try? encoder.encode(query)
		case .getPost:
			return nil
		case .signUp(let data):
			let encoder = JSONEncoder()
			encoder.keyEncodingStrategy = .convertToSnakeCase
			return try? encoder.encode(data)
		}
	}
}
