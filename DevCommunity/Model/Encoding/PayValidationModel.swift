//
//  PayValidationRequestModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/6/24.
//

import Foundation

struct PayValidationModel: Encodable {
	let imp_uid: String
	let post_id: String
	let productName: String
	var price: Int = 100
}
