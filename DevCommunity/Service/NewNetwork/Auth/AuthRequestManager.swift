//
//  AuthRequestManager.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/2/24.
//

import Foundation
import Moya
import RxSwift

final class AuthRequestManager {
	private var provider = MoyaProvider<AuthRouter>()

	func accessTokenRequest() -> Single<Result<AccessTokenRefreshModel,Error>> {
		return Single<Result<AccessTokenRefreshModel,Error>>.create { single in
			self.provider.request(.access) { result in
				switch result {
				case .success(let result):
					do {
						single(.success(.success(try result.map(AccessTokenRefreshModel.self))))
					} catch {
						single(.success(.failure(error)))
					}
				case .failure(let error):
					single(.success(.failure(error)))
				}
			}
			return Disposables.create()
		}
	}

	func loginRequest(_ query: LoginRequestModel) -> Single<Result<LoginResultModel,Error>> {
		return Single<Result<LoginResultModel,Error>>.create { single in
			self.provider.request(.login(query: query)) { result in
				switch result {
				case .success(let result):
					do {
						single(.success(.success(try result.map(LoginResultModel.self))))
					} catch {
						single(.success(.failure(error)))
					}
				case .failure(let error):
					single(.success(.failure(error)))
				}
			}
			return Disposables.create()
		}
	}

	func withDrawRequstModel() -> Single<Result<WithDrawResultModel, Error>> {
		return Single<Result<WithDrawResultModel, Error>>.create { single in
			self.provider.request(.withDraw) { result in
				switch result {
				case .success(let result):
					do {
						single(.success(.success(try result.map(WithDrawResultModel.self))))
					} catch {
						single(.success(.failure(error)))
					}
				case .failure(let error):
					single(.success(.failure(error)))
				}
			}
			return Disposables.create()
		}
	}

}
