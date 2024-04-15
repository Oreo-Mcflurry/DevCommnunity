//
//  LoginModel.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/15/24.
//

import Foundation

struct LoginModel: Decodable {
	let user_id: String
	let email: String
	let nick: String
	let accessToken: String
	let refreshToken: String
}
