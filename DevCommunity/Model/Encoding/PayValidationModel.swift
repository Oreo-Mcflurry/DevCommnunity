//
//  PayValidationRequestModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/6/24.
//

import Foundation

struct PayValidationModel: Codable {
	let imp_uid: String
	let post_id: String
	let productName: String
	let price: Int = 100
}
