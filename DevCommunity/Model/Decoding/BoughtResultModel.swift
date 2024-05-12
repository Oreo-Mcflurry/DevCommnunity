//
//  BoughtResultModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/12/24.
//

import Foundation

struct BoughtResultModel: Decodable {
	let data: [BoughtResult]
}

struct BoughtResult: Decodable {
	let paidAt: String
	let post_id: String
}
