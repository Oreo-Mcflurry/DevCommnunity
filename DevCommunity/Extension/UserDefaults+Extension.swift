//
//  UserDefaults+Extension.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/22/24.
//

import Foundation

extension UserDefaults {
	enum UserDefaultsStringKeys: String, CaseIterable {
		case emailId
		case password
		case accessToken
		case refreshToken
		case userId
		case userNickname
	}

	subscript(_ item: UserDefaultsStringKeys) -> String {
		get {
			return UserDefaults.standard.string(forKey: item.rawValue) ?? ""
		} set {
			UserDefaults.standard.setValue(newValue, forKey: item.rawValue)
		}
	}

	func saveLoginResult(_ data: LoginResultModel) {
		UserDefaults.standard[.accessToken] = data.accessToken
		UserDefaults.standard[.refreshToken] = data.refreshToken
		UserDefaults.standard[.emailId] = data.email
		UserDefaults.standard[.userNickname] = data.nick
		UserDefaults.standard[.userId] = data.user_id
	}

	func saveLoginRequest(_ data: LoginRequestModel) {
		UserDefaults.standard[.password] = data.password
		UserDefaults.standard[.emailId] = data.email
	}

	func saveSignUpRequest(_ data: SignUpRequetModel) {
		UserDefaults.standard[.emailId] = data.email
		UserDefaults.standard[.password] = data.password
		UserDefaults.standard[.userNickname] = data.nick
	}

	func deleteAll() {
		for item in UserDefaultsStringKeys.allCases {
			UserDefaults.standard[item] = ""
		}
	}
}
