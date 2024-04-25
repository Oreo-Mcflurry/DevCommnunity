//
//  PostsResultModel.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/16/24.
//

import Foundation
import Differentiator

struct EventPostsResultModel: Decodable {
	var data: [EventPost]
	let nextCursor: String

	enum CodingKeys: String, CodingKey {
		case data = "data"
		case nextCursor = "next_cursor"
	}
}

struct EventPost: Decodable {
	let postID: String
	let productID: String
	private let content: String
	private let content1: String
	let time: String
	let organizer: String
	private let url: String
	let recruitProductId: String
	let createdAt: String
	let creator: Creator
	let files: [String]
	private let likes: [String]
	private let likes2: [String]
	private let hashTag: [String]
	let title: String

	var dateStart: Date {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter.date(from: content1) ?? Date()
	}

	var date: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy년 MM월 dd일 (EEE)"
		formatter.locale = Locale(identifier: "ko_kr")
		return formatter.string(from: dateStart)
	}

	var dDay: String {
		let calendar = Calendar.current
		let day = calendar.dateComponents([.day], from: dateStart, to: Date()).day ?? 0
		return day == 0 ? "D-day" : "D\(day)"
	}

	var month: Int {
		let calendar = Calendar.current
		let month = calendar.dateComponents([.month], from: dateStart).month ?? 0
		return month
	}

	var hashTags: String {
		return hashTag.map{ "#\($0)" }.joined(separator: " ")
	}

	var imageURL: URL {
		if let fileURL = files.first  {
			return URL(string: APIKey.baseURL.rawValue + "/v1/" + fileURL)!
		}
		return URL(string: APIKey.baseURL.rawValue)!
	}

	var likeString: String {
		return "관심 \(likes.count)"
	}

	enum CodingKeys: String, CodingKey {
		case postID = "post_id"
		case productID = "product_id"
		case content = "content"
		case content1 = "content1"
		case time = "content2"
		case organizer = "content3"
		case url = "content4"
		case recruitProductId = "content5"
		case createdAt = "createdAt"
		case creator = "creator"
		case files = "files"
		case likes = "likes"
		case likes2 = "likes2"
		case hashTag = "hashTags"
		case title = "title"
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.postID = try container.decodeIfPresent(String.self, forKey: .postID) ?? ""
		self.productID = try container.decodeIfPresent(String.self, forKey: .productID) ?? ""
		self.content = try container.decodeIfPresent(String.self, forKey: .content) ?? ""
		self.content1 = try container.decodeIfPresent(String.self, forKey: .content1) ?? ""
		self.time = try container.decodeIfPresent(String.self, forKey: .time) ?? ""
		self.organizer = try container.decodeIfPresent(String.self, forKey: .organizer) ?? ""
		self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
		self.recruitProductId = try container.decodeIfPresent(String.self, forKey: .recruitProductId) ?? ""
		self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
		self.creator = try container.decodeIfPresent(Creator.self, forKey: .creator) ?? Creator(userID: "", nick: "")
		self.files = try container.decodeIfPresent([String].self, forKey: .files) ?? []
		self.likes = try container.decodeIfPresent([String].self, forKey: .likes) ?? []
		self.likes2 = try container.decodeIfPresent([String].self, forKey: .likes2) ?? []
		self.hashTag = try container.decodeIfPresent([String].self, forKey: .hashTag) ?? []
		self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
	}

	init() {
		self.postID = UUID().uuidString
		self.productID = ""
		self.content = ""
		self.content1 =  ""
		self.time = ""
		self.organizer = ""
		self.url = ""
		self.recruitProductId = ""
		self.createdAt = ""
		self.creator = Creator(userID: "", nick: "")
		self.files = []
		self.likes = []
		self.likes2 = []
		self.hashTag = []
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
