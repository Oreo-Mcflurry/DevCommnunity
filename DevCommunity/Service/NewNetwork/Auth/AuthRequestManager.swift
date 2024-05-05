//
//  AuthRequestManager.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/2/24.
//

import Foundation
import Moya
import RxSwift

// 위와 같은 방법으로 좀 더 어케 하면 개선시킬 수 있을거같은데... 시간이 얼마 없어서 일단 진행해보겠습니다.. Decoding코드만 어케 빼볼려고 했는데, 도저히 공수 시간이 안나오네요
//
//extension CustomTargetType {
//	func request(_ target: CustomTargetType) -> Single<Result<T, Error>> {
//		return Single<Result<target.decodeModel,Error>>.create { single in
//			self.provider.request(.access) { response in
//				switch response {
//				case .success(let result):
//					do {
//						single(.success(.success(try result.map(AccessTokenRefreshModel.self))))
//					} catch {
//						single(.success(.failure(error)))
//					}
//				case .failure(let error):
//					single(.success(.failure(error)))
//				}
//			}
//			return Disposables.create()
//		}	}
//}
//class API {
//	let provider = MoyaProvider<AuthRouter>()
//	 func request<T: Decodable>(_ api: AuthRouter) -> Single<Result<T, Error>> {
//		  return Single.create { single in
//			  self.provider.request(api) { response in
//				  switch response {
//				  case .success(let result):
//					  do {
//						  single(.success(.success(try result.map(T.self))))
//					  } catch {
//						  single(.success(.failure(error)))
//					  }
//				  case .failure(let error):
//					  single(.success(.failure(error)))
//				  }
//			  }
//
//			  return Disposables.create()
//		  }
//	 }
//}


final class AuthRequestManager: BaseRequestManager {

	private var provider = MoyaProvider<AuthRouter>(session: Session(interceptor: Interceptor.shared), plugins: [MoyaLogger()])
	func accessTokenRequest() -> Single<Result<AccessTokenRefreshModel,Error>> {
		return Single<Result<AccessTokenRefreshModel,Error>>.create { single in
			self.provider.request(.access) { response in
				self.requestHandling(single, response: response)
			}
			return Disposables.create()
		}
	}

	func loginRequest(_ query: LoginRequestModel) -> Single<Result<LoginResultModel,Error>> {
		return Single<Result<LoginResultModel,Error>>.create { single in
			self.provider.request(.login(query: query)) { response in
				self.requestHandling(single, response: response)
			}
			return Disposables.create()
		}
	}

	func withDrawRequst() -> Single<Result<WithDrawResultModel, Error>> {
		return Single<Result<WithDrawResultModel, Error>>.create { single in
			self.provider.request(.withDraw) { response in
				self.requestHandling(single, response: response)
			}
			return Disposables.create()
		}
	}

	func signUpRequest(_ data: SignUpRequetModel) -> Single<Result<SignUpResultModel, Error>> {
		return Single<Result<SignUpResultModel, Error>>.create { single in
			self.provider.request(.signUp(data: data)) { response in
				self.requestHandling(single, response: response)
			}
			return Disposables.create()
		}
	}
}
