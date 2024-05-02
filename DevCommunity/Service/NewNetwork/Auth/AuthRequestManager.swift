//
//  AuthRequestManager.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/2/24.
//

import Foundation
import Moya

final class AuthRequestManager {
	private var provider = MoyaProvider<AuthRouter>()

	func accessTokenRequest() {
		provider.request(.access) { result in
			print("================================================")
			switch result {
			case .success(let result):
				let test = try? result.map(AccessTokenRefresh.self)
				print("================================================", test)
			case .failure(let fail):
				print("================================================", fail)
			}
		}
	}

	func loginRequest(_ query: LoginRequestModel) {
		provider.request(.login(query: query)) { result in
			switch result {
			case .success(let result):
				let test = try? result.map(AccessTokenRefresh.self)
				print("================================================", test)
			case .failure(let fail):
				print("================================================", fail)
			}
		}
	}

}
