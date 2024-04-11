//
//  Router.swift
//  LSLPBasic
//
//  Created by A_Mcflurry on 4/9/24.
//

import Foundation
import Alamofire

enum Router {
	case login(query: LoginQuery)
	case withDraw
	case fetchPost
	case uploadPost
}

extension Router: TargetType {

	func asURLRequest() throws -> URLRequest {
		<#code#>
	}

	var baseURL: String {
		return APIKey.baseURL.rawValue
	}

	var method: HTTPMethod {
		return .post
	}

	var header: [String : String] {
		return [
			HTTPHeader.contentType.rawValue: "application/json",
			HTTPHeader.sesackey.rawValue: APIKey.sesacKey.rawValue
		]
	}

	var path: String {
		return "/users/login"
	}

	var parameters: String? {
		return nil
	}

	var queryItems: [URLQueryItem]? {
		return nil
	}

	var body: Data? {
		switch self {
		case .login(let query):
			let encoder = JSONEncoder()
			encoder.keyEncodingStrategy = .convertToSnakeCase
			return try? encoder.encode(query)
		default: return nil
		}
	}
}
