//
//  PostsRequestModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/19/24.
//

import Foundation

struct PostsRequestModel: Encodable {
	 var next: String
	 var limit = "1000"
	 var product_id = "DevCommunity"
}

extension PostsRequestModel {
	var queryItem: [String: String] {
		return [
			"next": next,
			"limit": limit,
			"product_id": product_id
		]
	}
}

