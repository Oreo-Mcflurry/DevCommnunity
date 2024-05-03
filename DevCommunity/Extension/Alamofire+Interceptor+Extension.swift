//
//  Alamofire+Interceptor+Extension.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/2/24.
//

import Foundation
import Alamofire
import RxSwift
import Moya

extension TargetType {
	var validationType: ValidationType {
		return .successCodes
	}
}

protocol RequestInterceptor: RequestAdapter, RequestRetrier {
	var disposeBag: DisposeBag { get }
}

extension RequestInterceptor {

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
// 오늘 할일: 키체인, 유저디폴트 매니저, Rx + Interceptor + Moya

// 내일 할일: 댓글로 참가 로직, 뷰 만들기

// 주말에 할일: 광고 제거 결제 + 세팅뷰 (SwiftUI로 빠르게 그리기)//			.subscribe(with: <#T##Object#>, onSuccess: <#T##((Object, Result<AccessTokenRefreshModel, any Error>) -> Void)?##((Object, Result<AccessTokenRefreshModel, any Error>) -> Void)?##(Object, Result<AccessTokenRefreshModel, any Error>) -> Void#>)

