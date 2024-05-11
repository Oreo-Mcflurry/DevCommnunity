//
//  ProfileRouter.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/10/24.
//

import Foundation
import Moya

enum ProfileRouter {
	case profileEdit(query: ProfileEditModel)
	case getMyProfile
}

extension ProfileRouter: TargetType {
	var baseURL: URL {
		return URL(string: APIKey.baseURL.rawValue)!
	}

	var path: String {
		return "v1/users/me/profile"
	}

	var method: Moya.Method {
		switch self {
		case .profileEdit:
				return .put
		case .getMyProfile:
			return .get
		}
	}

	var task: Moya.Task {
		switch self {
		case .profileEdit(let query):
			return .requestJSONEncodable(query)
		case .getMyProfile:
			return .requestParameters(parameters: headers ?? [:], encoding: URLEncoding.default)
		}
	}

	var headers: [String : String]? {
		switch self {
		case .profileEdit:
			return [
				HTTPHeader.authorization.rawValue: UserDefaults.standard[.accessToken],
				HTTPHeader.sesackey.rawValue: APIKey.sesacKey.rawValue,
				HTTPHeader.contentType.rawValue: HTTPHeader.multipart.rawValue
			]
		case .getMyProfile:
			return [
				HTTPHeader.authorization.rawValue: UserDefaults.standard[.accessToken],
				HTTPHeader.sesackey.rawValue: APIKey.sesacKey.rawValue
			]
		}
	}
}
