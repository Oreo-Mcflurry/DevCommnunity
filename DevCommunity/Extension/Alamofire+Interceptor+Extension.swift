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

// 오늘 할일: 키체인, 유저디폴트 매니저, Rx + Interceptor + Moya

// 내일 할일: 댓글로 참가 로직, 뷰 만들기

// 주말에 할일: 광고 제거 결제 + 세팅뷰 (SwiftUI로 빠르게 그리기)//			.subscribe(with: <#T##Object#>, onSuccess: <#T##((Object, Result<AccessTokenRefreshModel, any Error>) -> Void)?##((Object, Result<AccessTokenRefreshModel, any Error>) -> Void)?##(Object, Result<AccessTokenRefreshModel, any Error>) -> Void#>)

