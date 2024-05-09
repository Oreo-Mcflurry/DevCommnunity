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
	let discriptionText: String
	private let createdAt: String
	let creator: Creator
	let files: [String]
	private var likes: [String]
	private let likes2: [String]
	private let hashTags: [String]
	private var appliedInfo: [AppliedInfo]
	let title: String

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
		case appliedInfo = "comments"
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.postID = try container.decodeIfPresent(String.self, forKey: .postID) ?? ""
		self.productID = try container.decodeIfPresent(String.self, forKey: .productID) ?? ""
		self.content = try container.decodeIfPresent(String.self, forKey: .content) ?? ""
		self.content1 = try container.decodeIfPresent(String.self, forKey: .content1) ?? ""
		self.content2 = try container.decodeIfPresent(String.self, forKey: .content2) ?? ""
		self.content3 = try container.decodeIfPresent(String.self, forKey: .content3) ?? ""
		self.discriptionText = try container.decodeIfPresent(String.self, forKey: .mainText) ?? ""
		self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
		self.creator = try container.decodeIfPresent(Creator.self, forKey: .creator) ?? Creator(userID: "", nick: "")
		self.files = try container.decodeIfPresent([String].self, forKey: .files) ?? []
		self.likes = try container.decodeIfPresent([String].self, forKey: .likes) ?? []
		self.likes2 = try container.decodeIfPresent([String].self, forKey: .likes2) ?? []
		self.hashTags = try container.decodeIfPresent([String].self, forKey: .hashTags) ?? []
		self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
		self.appliedInfo = try container.decodeIfPresent([AppliedInfo].self, forKey: .appliedInfo) ?? []
	}

	init() {
		self.postID = UUID().uuidString
		self.productID = ""
		self.content = ""
		self.content1 =  ""
		self.content2 = ""
		self.content3 = ""
		self.appliedInfo = []
		self.discriptionText = ""
		self.createdAt = ""
		self.creator = Creator(userID: "", nick: "")
		self.files = []
		self.likes = []
		self.likes2 = []
		self.hashTags = []
		self.title = ""
	}
}

extension PartyPost {
	var dateStart: Date {
		return DateFormatter.formatter.date(from: content1) ?? Date()
	}

	var dateEnd: Date {
		return DateFormatter.formatter.date(from: content2) ?? Date()
	}

	var dDay: String {
		let calendar = Calendar.current
		let day = calendar.dateComponents([.day], from: dateEnd, to: Date()).day ?? 0
		return day == 0 ? "D-day" : "D\(day)"
	}

	var partyMax: String {
		return "\(Int(content3) ?? 0)명 모집"
	}

	var recruitmentString: [String] {
		return hashTags.map { $0.split(separator: ";").joined(separator: " ") + "명" }
	}

	var recruitmentTuple: [(job: String, maxParty: String)] {
		return hashTags.map { $0.split(separator: ";") }.map { (job: "\($0[0])", maxParty: "\($0[1])") }
	}

	var createDate: String {
		let formatter = DateFormatter()
		let data = formatter.date(from: createdAt) ?? Date()
		formatter.dateFormat = "MM/dd hh:mm"
		return formatter.string(from: data)
	}

	var isCreator: Bool {
		return creator.userID == UserDefaults.standard[.userId]
	}

	var isBookmarked: Bool {
		get {
			return likes.contains(UserDefaults.standard[.userId])
		} set {
			if newValue {
				likes.append(UserDefaults.standard[.userId])
			} else {
				likes.enumerated().forEach { index, item in
					if item == UserDefaults.standard[.userId] {
						likes.remove(at: index)
					}
				}
			}
		}
	}

	var isJoined: Bool {
		get {
			return !appliedInfo.filter { $0.creator.userID == UserDefaults.standard[.userId] }.isEmpty
		} set {
			if newValue {
				appliedInfo.append(AppliedInfo(comment_id: "", content: "", creator: Creator(userID: UserDefaults.standard[.userId], nick: UserDefaults.standard[.userNickname])))
			}
		}
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

