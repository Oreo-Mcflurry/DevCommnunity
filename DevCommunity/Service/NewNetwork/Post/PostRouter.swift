//
//  PostRouter.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/3/24.
//

import Foundation
import Moya

enum PostRouter {
	case getPost(query: PostsRequestModel)
	case getPartyPost(query: PostsRequestModel)
	case like(postID: String, query: LikeRequestModel)
}

extension PostRouter: TargetType {
	var baseURL: URL {
		return URL(string: APIKey.baseURL.rawValue)!
	}
	
	var path: String {
		switch self {
		case .getPost, .getPartyPost:
			return "v1/posts"
		case .like(let postID, _):
			return "v1/posts/\(postID)/like"
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .getPost, .getPartyPost:
			return .get
		case .like:
			return .post
		}
	}
	
	var task: Moya.Task {
		switch self {
		case .getPost(let query):
			return .requestJSONEncodable(query)
		case .getPartyPost(let query):
			return .requestJSONEncodable(query)
		case .like(_, let query):
			return .requestJSONEncodable(query)
		}
	}
	
	var headers: [String : String]? {
		switch self {
		case .getPost, .getPartyPost:
			return [
				HTTPHeader.authorization.rawValue: UserDefaults.standard[.accessToken],
				HTTPHeader.sesackey.rawValue: APIKey.sesacKey.rawValue
			]
		case .like:
			return [
				HTTPHeader.authorization.rawValue: UserDefaults.standard[.accessToken],
				HTTPHeader.sesackey.rawValue: APIKey.sesacKey.rawValue,
				HTTPHeader.contentType.rawValue: HTTPHeader.json.rawValue
			]
		}
	}
}
