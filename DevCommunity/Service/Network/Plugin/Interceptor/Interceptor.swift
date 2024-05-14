//
//  Interceptor.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/3/24.
//

import Foundation
import RxSwift
import Alamofire
import Moya

final class Interceptor {
	private let disposeBag: DisposeBag
	static let shared = Interceptor()

	private init() {
		disposeBag = DisposeBag()
	}
}

extension Interceptor: RequestInterceptor {

	func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
		return completion(.success(urlRequest))
	}

	func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
		let requestManager = AuthRequestManager()

		guard let response = request.response else {
			completion(.doNotRetryWithError(error))
			return
		}

		if response.statusCode != 401 || response.statusCode != 418 {
			completion(.doNotRetryWithError(error))
			return
		}

		requestManager.accessTokenRequest()
			.subscribe { response in
				switch response {
				case .success(let result):
					switch result {
					case .success(let accessToken):
						UserDefaults.standard[.accessToken] = accessToken.accessToken
						completion(.retry)
					case .failure(let error):
						completion(.doNotRetryWithError(error))
					}
				case .failure(let error):
					completion(.doNotRetryWithError(error))
				}
			}.disposed(by: disposeBag)
	}
}
