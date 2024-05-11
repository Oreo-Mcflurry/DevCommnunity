//
//  PayRequestModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/6/24.
//

import Foundation
import Moya
import RxSwift

final class PayRequestManager: BaseRequestManager {

	private var provider = MoyaProvider<PayRouter>(session: Session(interceptor: Interceptor.shared), plugins: [MoyaLogger(), MoyaCacheablePlugin()])

	func getPayValidation(query: PayValidationModel) -> Single<PayStatusCode> {
		return Single<PayStatusCode>.create { single in
			self.provider.request(.payValidation(query: query)) { response in
				switch response {
				case .success(let result):
					single(.success(PayStatusCode.getPayEnum(result.statusCode)))
				case .failure(_):
					single(.success(.error))
				}
			}
			return Disposables.create()
		}
	}

	enum PayStatusCode {
		case success
		case error
		case alreadyPay

		static func getPayEnum(_ statusCode: Int) -> PayStatusCode {
			if statusCode == 200 {
				return .success
			} else if statusCode == 409 {
				return .alreadyPay
			} else {
				return .error
			}
		}
	}
}
