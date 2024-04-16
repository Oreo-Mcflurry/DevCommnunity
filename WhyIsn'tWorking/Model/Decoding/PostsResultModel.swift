//
//  PostsResultModel.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/16/24.
//

import Foundation

struct PostsResultModel: Codable {
	 let data: [Datum]
	 let nextCursor: String

	 enum CodingKeys: String, CodingKey {
		  case data = "data"
		  case nextCursor = "next_cursor"
	 }
}

struct Datum: Codable {
	 let postID: String
	 let productID: String?
	 let content: String
	 let content1: String?
	 let content2: String?
	 let content3: String?
	 let content4: String?
	 let createdAt: String
	 let creator: Creator
	 let files: [String]
	 let likes: [String]
	 let likes2: [String]
	 let hashTags: [String]
	 let comments: [String]
	 let title: String?

	 enum CodingKeys: String, CodingKey {
		  case postID = "post_id"
		  case productID = "product_id"
		  case content = "content"
		  case content1 = "content1"
		  case content2 = "content2"
		  case content3 = "content3"
		  case content4 = "content4"
		  case createdAt = "createdAt"
		  case creator = "creator"
		  case files = "files"
		  case likes = "likes"
		  case likes2 = "likes2"
		  case hashTags = "hashTags"
		  case comments = "comments"
		  case title = "title"
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
