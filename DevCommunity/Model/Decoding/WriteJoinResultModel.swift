//
//  WriteJoinResultModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/5/24.
//

import Foundation

struct WriteJoinResultModel: Decodable {
	let comment_id: String
	let content: String
	let createdAt: String
	let creator: Creator
}
