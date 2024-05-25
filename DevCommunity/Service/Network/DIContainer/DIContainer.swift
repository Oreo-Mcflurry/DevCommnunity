//
//  DIContainer.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/25/24.
//

import Foundation

final class DIContainer {
	static let shared = DIContainer()
	private init() { }

	let interceptor = Interceptor()
	let moyaLogger = MoyaLogger()
	let moyaCacheablePlugin = MoyaCacheablePlugin()
}
