//
//  PostsResultModel.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/16/24.
//

import Foundation
import Differentiator

struct EventPostsResultModel: Codable {
	var data: [EventPost]
	let nextCursor: String

	enum CodingKeys: String, CodingKey {
		case data = "data"
		case nextCursor = "next_cursor"
	}
}

struct EventPost: Codable {
	let postID: String
	let productID: String
	private let content: String
	private let content1: String
	private let content2: String
	let organizer: String
	let url: String
	let recruitProductId: String
	let createdAt: String
	let creator: Creator
	let files: [String]
	private let likes: [String]
	private let likes2: [String]
	let hashTags: [String]
	let title: String

	var dateStart: Date {
		let formatter = DateFormatter()
		return formatter.date(from: content1) ?? Date()
	}

	var dateEnd: Date {
		let formatter = DateFormatter()
		return formatter.date(from: content2) ?? Date()
	}

	enum CodingKeys: String, CodingKey {
		case postID = "post_id"
		case productID = "product_id"
		case content = "content"
		case content1 = "content1"
		case content2 = "content2"
		case organizer = "content3"
		case url = "content4"
		case recruitProductId = "content5"
		case createdAt = "createdAt"
		case creator = "creator"
		case files = "files"
		case likes = "likes"
		case likes2 = "likes2"
		case hashTags = "hashTags"
		case title = "title"
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.postID = try container.decodeIfPresent(String.self, forKey: .postID) ?? ""
		self.productID = try container.decodeIfPresent(String.self, forKey: .productID) ?? ""
		self.content = try container.decodeIfPresent(String.self, forKey: .content) ?? ""
		self.content1 = try container.decodeIfPresent(String.self, forKey: .content1) ?? ""
		self.content2 = try container.decodeIfPresent(String.self, forKey: .content2) ?? ""
		self.organizer = try container.decodeIfPresent(String.self, forKey: .organizer) ?? ""
		self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
		self.recruitProductId = try container.decodeIfPresent(String.self, forKey: .recruitProductId) ?? ""
		self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
		self.creator = try container.decodeIfPresent(Creator.self, forKey: .creator) ?? Creator(userID: "", nick: "")
		self.files = try container.decodeIfPresent([String].self, forKey: .files) ?? []
		self.likes = try container.decodeIfPresent([String].self, forKey: .likes) ?? []
		self.likes2 = try container.decodeIfPresent([String].self, forKey: .likes2) ?? []
		self.hashTags = try container.decodeIfPresent([String].self, forKey: .hashTags) ?? []
		self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
	}

	init() {
		self.postID =  ""
		self.productID = ""
		self.content = ""
		self.content1 =  ""
		self.content2 = ""
		self.organizer = ""
		self.url = ""
		self.recruitProductId = ""
		self.createdAt = ""
		self.creator = Creator(userID: "", nick: "")
		self.files = []
		self.likes = []
		self.likes2 = []
		self.hashTags = []
		self.title = ""
	}
}

struct Creator: Codable {
	let userID: String
	let nick: String

	enum CodingKeys: String, CodingKey {
		case userID = "user_id"
		case nick = "nick"
	}
}


extension EventPost: IdentifiableType, Equatable {
	static func == (lhs: EventPost, rhs: EventPost) -> Bool {
		lhs.postID == rhs.postID
	}
	
	typealias Identity = String

	var identity: String {
		return postID
	}


}
