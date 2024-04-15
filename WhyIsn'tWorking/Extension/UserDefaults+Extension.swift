//
//  UserDefaults+Extension.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/22/24.
//

import Foundation

extension UserDefaults {
	enum UserDefaultsBoolKeys: String {
		case emailId
		case password
		case accessToken
		case refreshToken
		case userId
	}

	subscript(_ item: UserDefaultsBoolKeys) -> String {
		get {
			return UserDefaults.standard.string(forKey: item.rawValue) ?? ""
		} set {
			UserDefaults.standard.setValue(newValue, forKey: item.rawValue)
		}
	}
}
