//
//  LoginRouter.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/13/24.
//

//import Foundation
//import Alamofire
//
//enum Router {
//	case access
//	case login(query: LoginRequestModel)
//	case getPost(query: PostsRequestModel)
//	case signUp(data: SignUpRequetModel)
//	case getPartyPost(query: PostsRequestModel)
//	case like(postID: String, query: LikeRequestModel)
//}
//
//extension Router: AlamofireTargetType {
//
//	func asURLRequest() throws -> URLRequest {
//		let url = try baseURL.asURL()
//		var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
//
//		if let queryItems = queryItems {
//			urlRequest.url?.append(queryItems: queryItems)
//		}
//		urlRequest.allHTTPHeaderFields = header
//		urlRequest.httpBody = parameters?.data(using: .utf8)
//		urlRequest.httpBody = body
//		return urlRequest
//	}
//
//	var baseURL: String {
//		return APIKey.baseURL.rawValue
//	}
//
//	var method: Alamofire.HTTPMethod {
//		switch self {
//		case .access:
//			return .get
//		case .login:
//			return .post
//		case .getPost:
//			return .get
//		case .signUp:
//			return .post
//		case .getPartyPost:
//			return .get
//		case .like:
//			return .post
//		}
//	}
//
//	var header: [String : String] {
//		switch self {
//		case .access:
//			return [
//				HTTPHeader.refresh.rawValue: UserDefaults.standard[.refreshToken],
//				HTTPHeader.sesackey.rawValue: APIKey.sesacKey.rawValue,
//				HTTPHeader.authorization.rawValue: UserDefaults.standard[.accessToken]
//			]
//		case .login, .signUp:
//			return [
//				HTTPHeader.contentType.rawValue: HTTPHeader.json.rawValue,
//				HTTPHeader.sesackey.rawValue: APIKey.sesacKey.rawValue
//			]
//		case .getPost, .getPartyPost:
//			return [
//				HTTPHeader.authorization.rawValue: UserDefaults.standard[.accessToken],
//				HTTPHeader.sesackey.rawValue: APIKey.sesacKey.rawValue
//			]
//
//		case .like:
//			return [
//				HTTPHeader.authorization.rawValue: UserDefaults.standard[.accessToken],
//				HTTPHeader.sesackey.rawValue: APIKey.sesacKey.rawValue,
//				HTTPHeader.contentType.rawValue: HTTPHeader.json.rawValue
//			]
//		}
//	}
//
//	var path: String {
//		switch self {
//		case .access:
//			return "v1/auth/refresh"
//		case .login:
//			return "v1/users/login"
//		case .getPost, .getPartyPost:
//			return "v1/posts"
//		case .signUp:
//			return "v1/users/join"
//		case .like(let postID, _):
//			return "v1/posts/\(postID)/like"
//		}
//	}
//
//	var parameters: String? {
//		return nil
//	}
//	
//	var queryItems: [URLQueryItem]? {
//		switch self {
//		case .getPost(let query):
//			return query.queryItems
//
//		case .getPartyPost(let query):
//			return query.queryItems
//		default:
//			return nil
//		}
//	}
//	
//	var body: Data? {
//		switch self {
//		case .access:
//			return nil
//		case .login(let data):
//			return encoding(data: data)
//		case .getPost, .getPartyPost:
//			return nil
//		case .signUp(let data):
//			return encoding(data: data)
//		case .like(_, let data):
//			return encoding(data: data)
//		}
//	}
//
//	private func encoding(data: Encodable) -> Data? {
//		let encoder = JSONEncoder()
//		encoder.keyEncodingStrategy = .convertToSnakeCase
//		return try? encoder.encode(data)
//	}
//}
