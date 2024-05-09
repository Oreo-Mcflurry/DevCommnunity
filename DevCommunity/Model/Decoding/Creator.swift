//
//  Creator.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/9/24.
//

import Foundation

struct Creator: Decodable {
	let userID: String
	let nick: String

	enum CodingKeys: String, CodingKey {
		case userID = "user_id"
		case nick = "nick"
	}
}
