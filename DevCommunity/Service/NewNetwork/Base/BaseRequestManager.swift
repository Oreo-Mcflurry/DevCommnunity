//
//  BaseRequestManager.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/5/24.
//

import Foundation
import Moya
import RxSwift

class BaseRequestManager {
	func requestHandling<T: Decodable>(_ single: (Result<Result<T, any Error>, any Error>) -> Void, response: Result<Response, MoyaError>) {
		switch response {
		case .success(let result):
			 do {
				 let posts = try result.map(T.self)
				  single(.success(.success(posts)))
			 } catch {
				  single(.success(.failure(error)))
			 }
		case .failure(let error):
			 single(.success(.failure(error)))
		}
	}

	enum RequestError: Error {
		case urlError
	}
}
