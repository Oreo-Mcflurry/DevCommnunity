//
//  UserDefaults+Extension.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/22/24.
//

import Foundation

extension UserDefaults {
	enum UserDefaultsStringKeys: String {
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
}
