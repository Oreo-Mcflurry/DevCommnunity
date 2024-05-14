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

	func getPayValidation(query: PayValidationModel) -> Single<Int> {
		return Single<Int>.create { single in
			self.provider.request(.payValidation(query: query)) { response in
				switch response {

				case .success(let result):
					single(.success(result.statusCode))
				case .failure(_):
					single(.success(400))
				}
			}
			return Disposables.create()
		}
	}

	func getIsUserBought() -> Single<Result<BoughtResultModel, Error>> {
		return Single<Result<BoughtResultModel, Error>>.create { single in
			self.provider.request(.isUserBought) { response in
				debugPrint(response)
				self.requestHandling(single, response: response)
			}
			return Disposables.create()
		}
	}
}
