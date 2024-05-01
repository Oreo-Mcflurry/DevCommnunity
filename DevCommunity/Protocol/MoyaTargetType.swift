//
//  MoyaTargetType.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/1/24.
//

import Foundation
import Alamofire
import Moya

protocol MoyaTargetType: TargetType, URLRequestConvertible {
	var parameters: String? { get }
	var queryItems: [URLQueryItem]? { get }
	var body: Data? { get }
}
