//
//  MoyaCache.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/5/24.
//

import Foundation
import Moya

protocol MoyaCacheable {
  typealias MoyaCacheablePolicy = URLRequest.CachePolicy
  var cachePolicy: MoyaCacheablePolicy { get }
}

final class MoyaCacheablePlugin: PluginType {
  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
	 if let moyaCachableProtocol = target as? MoyaCacheable {
		var cachableRequest = request
		cachableRequest.cachePolicy = moyaCachableProtocol.cachePolicy
		return cachableRequest
	 }
	 return request
  }
}
