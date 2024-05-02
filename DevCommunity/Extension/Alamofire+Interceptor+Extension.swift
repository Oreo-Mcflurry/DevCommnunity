//
//  Alamofire+Interceptor+Extension.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/2/24.
//

import Foundation
import Alamofire

protocol RequestInterceptor: RequestAdapter, RequestRetrier {  }

extension RequestInterceptor {
	func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
		return completion(.success(urlRequest))
	}

	func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {

		guard let response = request.response else {
			completion(.doNotRetryWithError(error))
			return
		}

		if response.statusCode != 401 {
			completion(.doNotRetry)
			return
		}

		// Refresh 로직
		completion(.retry)
	}
}
// 오늘 할일: 키체인, 유저디폴트 매니저, Rx + Interceptor + Moya

// 내일 할일: 댓글로 참가 로직, 뷰 만들기

// 주말에 할일: 광고 제거 결제 + 세팅뷰 (SwiftUI로 빠르게 그리기)
