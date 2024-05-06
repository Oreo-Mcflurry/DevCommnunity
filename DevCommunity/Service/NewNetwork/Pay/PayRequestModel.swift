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

	func getPayValidation(query: PayValidationModel) -> Single<Result<PayValidationModel, Error>> {
		return Single<Result<PayValidationModel, Error>>.create { single in
			self.provider.request(.payValidation(query: query)) { response in
				self.requestHandling(single, response: response)
			}
			return Disposables.create()
		}
	}

}
