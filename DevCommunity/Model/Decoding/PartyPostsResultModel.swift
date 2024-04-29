//
//  PartyPostsModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/19/24.
//

import Foundation
import Differentiator

struct PartyPostsResultModel: Decodable {
	var data: [PartyPost]
	let nextCursor: String

	enum CodingKeys: String, CodingKey {
		case data = "data"
		case nextCursor = "next_cursor"
	}
}

struct PartyPost: Decodable {
	let postID: String
	let productID: String
	private let content: String
	private let content1: String
	private let content2: String
	private let content3: String
	let mainText: String
	let createdAt: String
	let creator: Creator
	let files: [String]
	private let likes: [String]
	private let likes2: [String]
	private let hashTags: [String]
	let title: String

	var dateStart: Date {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter.date(from: content1) ?? Date()
	}

	var dateEnd: Date {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter.date(from: content2) ?? Date()
	}

	var dDay: String {
		let calendar = Calendar.current
		let day = calendar.dateComponents([.day], from: dateEnd, to: Date()).day ?? 0
		return day == 0 ? "D-day" : "D\(day)"
	}

	var maxPeople: String {
		return "\(Int(content3) ?? 0)명 구인"
	}

	var isBookmarked: Bool {
		return likes.contains(UserDefaults.standard[.userId])
	}

	var isJoined: Bool {
		return likes2.contains(UserDefaults.standard[.userId])
	}

	var hashTagString: [String] {
		return hashTags.map { $0.split(separator: ";").joined(separator: " ") + "명" }
	}

	enum CodingKeys: String, CodingKey {
		case postID = "post_id"
		case productID = "product_id"
		case content = "content"
		case content1 = "content1"
		case content2 = "content2"
		case content3 = "content3"
		case mainText = "content4"
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
		self.content3 = try container.decodeIfPresent(String.self, forKey: .content3) ?? ""
		self.mainText = try container.decodeIfPresent(String.self, forKey: .mainText) ?? ""
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
		self.content3 = ""
		self.mainText = ""
		self.createdAt = ""
		self.creator = Creator(userID: "", nick: "")
		self.files = []
		self.likes = []
		self.likes2 = []
		self.hashTags = []
		self.title = ""
	}
}

extension PartyPost: IdentifiableType, Equatable {
	static func == (lhs: PartyPost, rhs: PartyPost) -> Bool {
		lhs.postID == rhs.postID
	}

	typealias Identity = String

	var identity: String {
		return postID
	}
}

