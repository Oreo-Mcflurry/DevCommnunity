//
//  UserDefaults+Extension.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/22/24.
//

import Foundation

extension UserDefaults {
	enum UserDefaultsBoolKeys: String {
		case isFirstRun
	}

	subscript(item: UserDefaultsBoolKeys) -> Bool {
		get {
			return UserDefaults.standard.bool(forKey: item.rawValue)
		} set {
			UserDefaults.standard.setValue(newValue, forKey: item.rawValue)
		}
	}
}
