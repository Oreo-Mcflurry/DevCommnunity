//
//  PostsRequestModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/19/24.
//

import Foundation

struct PostsRequestModel: Encodable {
	 let next: String
	 let limit = "1000"
	 var product_id = "DevCommunity"
}

extension PostsRequestModel {
	 var queryItems: [URLQueryItem]? {
		  let encoder = JSONEncoder()
		  guard let jsonData = try? encoder.encode(self) else {
				return nil
		  }

		  guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
				return nil
		  }

		  return jsonObject.compactMap { key, value in
				guard let encodedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
					 return nil
				}
				return URLQueryItem(name: key, value: encodedValue)
		  }
	 }
}

