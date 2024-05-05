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

		if response.statusCode != 401 {
			completion(.doNotRetryWithError(error))
			return
		}

		requestManager.accessTokenRequest()
			.subscribe { response in
				switch response {
				case .success(let result):

					switch result {
					case .success(let accessToken):
						// 이런걸 빼려고 리팩토링 하는데 얘는 도저히 이걸 어디서 뺄 각이 안보입니다... ㅠㅜㅠㅠㅠㅠㅠ
						UserDefaults.standard[.accessToken] = accessToken.accessToken
						completion(.retry)
					case .failure(let error):
						completion(.doNotRetryWithError(error))
					}
				case .failure(_): break;
				}
			}.disposed(by: disposeBag)

		completion(.retry)
	}
}
