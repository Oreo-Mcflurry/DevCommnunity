//
//  TargetType.swift
//  LSLPBasic
//
//  Created by A_Mcflurry on 4/9/24.
//

import Foundation
import Alamofire

protocol TargetType: URLRequestConvertible {
	var baseURL: String { get }
	var method: HTTPMethod { get }
	var header: [String: String] { get }
	var path: String { get }
	var parameters: String? { get }
	var queryItems: [URLQueryItem]? { get }
	var body: Data? { get }
}
