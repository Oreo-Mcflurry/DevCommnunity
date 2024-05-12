//
//  PayStatusCode.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/12/24.
//

import Foundation

enum PayStatusCode {
	case success
	case error
	case alreadyPay

	static func getPayEnum(_ statusCode: Int) -> PayStatusCode {
		if statusCode == 200 {
			return .success
		} else if statusCode == 409 {
			return .alreadyPay
		} else {
			return .error
		}
	}
}
