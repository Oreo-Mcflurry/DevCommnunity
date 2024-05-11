//
//  Comments.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/9/24.
//

import Foundation
import Differentiator

struct AppliedInfo: Decodable {
	let comment_id: String
	let content: String
	let creator: Creator

	init() {
		self.comment_id = ""
		self.content = ""
		self.creator = Creator(userID: "", nick: "")
	}

	init(comment_id: String, content: String, creator: Creator) {
		self.comment_id = comment_id
		self.content = content
		self.creator = creator
	}
}

extension AppliedInfo {
	private var part: [String] {
		return content.components(separatedBy: ";").count == 3 ? content.components(separatedBy: ";") : ["", "", ""]
	}

	var joinNickName: String {
		return part[0]
	}

	var introduce: String {
		return part[1]
	}

	var job: String {
		return part[2]
	}
}

extension AppliedInfo: IdentifiableType, Equatable {
	static func == (lhs: AppliedInfo, rhs: AppliedInfo) -> Bool {
		lhs.comment_id == rhs.comment_id
	}

	typealias Identity = String

	var identity: String {
		return comment_id
	}
}

