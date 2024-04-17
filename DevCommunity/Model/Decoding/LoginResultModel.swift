//
//  LoginResultModel.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/13/24.
//

import Foundation

struct LoginResultModel: Decodable {
	let user_id: String
	let email: String
	let nick: String
	let profileImage: String?
	let accessToken: String
	let refreshToken: String
}
