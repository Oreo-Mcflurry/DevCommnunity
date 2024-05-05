//
//  WritePostRequestModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/5/24.
//

import Foundation

struct WritePostRequestModel: Encodable {
	var product_id: String
	let content: String
	let content1: String
	let content2: String
	let content3: String
	let content4: String
	let content5: String
	let title: String
}
