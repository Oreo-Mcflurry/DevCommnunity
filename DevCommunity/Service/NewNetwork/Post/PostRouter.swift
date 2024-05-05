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
	case writePost(data: WritePostRequestModel)
	case writeJoin(postID: String, data: JoinRequestModel)
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
		case .writePost:
			return "v1/posts"
		case .writeJoin(let postID, _):
			return "v1/posts/\(postID)/comments"
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .getPost, .getPartyPost:
			return .get
		case .like:
			return .post
		case .writePost, .writeJoin:
			return .post
		}
	}
	
	var task: Moya.Task {
		switch self {
		case .getPost(let query):
			return .requestParameters(parameters: query.queryItem, encoding: URLEncoding.queryString)
		case .getPartyPost(let query):
			return .requestParameters(parameters: query.queryItem, encoding: URLEncoding.queryString)
		case .like(_, let query):
			return .requestJSONEncodable(query)
		case .writePost(let data):
			return .requestJSONEncodable(data)
		case .writeJoin(_, let data):
			return .requestJSONEncodable(data)
		}
	}
	
	var headers: [String : String]? {
		switch self {
		case .getPost, .getPartyPost:
			return [
				HTTPHeader.authorization.rawValue: UserDefaults.standard[.accessToken],
				HTTPHeader.sesackey.rawValue: APIKey.sesacKey.rawValue
			]
		case .like, .writePost, .writeJoin :
			return [
				HTTPHeader.authorization.rawValue: UserDefaults.standard[.accessToken],
				HTTPHeader.sesackey.rawValue: APIKey.sesacKey.rawValue,
				HTTPHeader.contentType.rawValue: HTTPHeader.json.rawValue
			]
		}
	}
}
