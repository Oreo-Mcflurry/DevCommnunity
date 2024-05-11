//
//  PayValidationResultModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/11/24.
//

import Foundation

struct PayValidationResultModel: Decodable {
//	let success: Bool
	let merchant_uid: String
	let imp_uid: String
}
