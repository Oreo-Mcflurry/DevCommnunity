//
//  NetworkManager.swift
//  LSLPBasic
//
//  Created by A_Mcflurry on 4/9/24.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

class RequestManager {

	enum APIError: Error {
		case urlError
		case tokenError
		case duplication
		case none
	}

	private func getErrorCase(code: Int?) -> APIError {
		guard let code else { return .none }

		if code == 409 {
			return .duplication
		} else {
			return .none
		}
	}

	private let disposeBag = DisposeBag()

	private func callRequest<T: Decodable>(_ api: Router, type: T.Type) -> Single<T> {
		return Single<T>.create { single in
			do {
				let urlRequest = try api.asURLRequest()
				AF.request(urlRequest)
					.validate(statusCode: 200..<300)
					.responseDecodable(of: T.self) { response in
						debugPrint(response)
						switch response.result {
						case .success(let result):
							single(.success(result))
						case .failure(_):
							single(.failure(self.getErrorCase(code: response.response?.statusCode)))
						}
					}
			} catch {
				single(.failure(error))
			}

			return Disposables.create()
		}
	}

	private func refreshAccessToken(_ completionHandler: @escaping ()->Void) {
		do {
			let query = LoginRequestModel(email: UserDefaults.standard[.emailId], password: UserDefaults.standard[.password])
			let urlRequest = try Router.login(query: query).asURLRequest()

			AF.request(urlRequest)
				.responseDecodable(of: LoginResultModel.self) { response in
					switch response.result {
					case .success(let result):
						UserDefaults.standard[.refreshToken] = result.refreshToken
						UserDefaults.standard[.accessToken] = result.accessToken
						completionHandler()
					case .failure(_):
						print("Fail")
					}
				}
		} catch {

		}
	}

	func createLogin(query: LoginRequestModel) -> Single<LoginResultModel> {
		return Single<LoginResultModel>.create { single in

			self.callRequest(.login(query: query), type: LoginResultModel.self)
				.subscribe { event in
					switch event {
					case .success(let result):
						UserDefaults.standard[.accessToken] = result.accessToken
						UserDefaults.standard[.refreshToken] = result.refreshToken
						UserDefaults.standard[.password] = query.password
						single(.success(result))
					case .failure(let error):
						single(.failure(error))
					}
				}.disposed(by: self.disposeBag)

			return Disposables.create()
		}
	}

	func createSignUp(data: SignUpRequetModel) -> Single<SignUpResultModel> {
		return Single<SignUpResultModel>.create { single in
			self.callRequest(.signUp(data: data), type: SignUpResultModel.self)
				.subscribe { event in
					switch event {
					case .success(let result):
						UserDefaults.standard[.emailId] = data.email
						UserDefaults.standard[.password] = data.password
						UserDefaults.standard[.userNickname] = result.nick
						UserDefaults.standard[.userId] = result.user_id
						single(.success(result))
					case .failure(let error):
						single(.failure(error))
					}
				}.disposed(by: self.disposeBag)
			return Disposables.create()
		}
	}

	func getPosts() -> Observable<PostsResultModel> {
		return Observable.create { observer -> Disposable in
			self.callRequest(.getPost, type: PostsResultModel.self)
				.subscribe { event in
					switch event {
					case .success(let result):
						observer.onNext(result)

					case .failure(_):
						self.refreshAccessToken {
							self.callRequest(.getPost, type: PostsResultModel.self)
								.map { $0 }
								.subscribe(with: self) { _, result in
									observer.onNext(result)
								} onFailure: { _, error in
									observer.onError(error)
								}.disposed(by: self.disposeBag)
						}
					}
				}
		}
	}
}


//	func callRequestResult<T: Decodable>(_ api: Router, type: T.Type) -> Single<Result<T, AFError>> {
//		return Single<Result<T, AFError>>.create { single in
//			do {
//				let urlRequest = try api.asURLRequest()
//				AF.request(urlRequest)
//					.validate(statusCode: 200..<300)
//					.responseDecodable(of: T.self) { response in
//						debugPrint(response)
//						switch response.result {
//						case .success(let result):
//							single(.success(.success(result)))
//						case .failure(let error):
//							single(.success(.failure(error)))
//						}
//					}
//			} catch {
//				single(.failure(error))
//			}
//
//			return Disposables.create()
//		}
//	}
