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

	private let disposeBag = DisposeBag()

	func callRequest<T: Decodable>(_ api: Router, type: T.Type) -> Single<T> {
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
						case .failure(let error):
							single(.failure(error))
						}
					}
			} catch {
				single(.failure(error))
			}

			return Disposables.create()
		}
	}

	func refreshAccessToken(_ completionHandler: @escaping ()->Void) {
		do {
			let urlRequest = try Router.access.asURLRequest()

			AF.request(urlRequest)
				.responseDecodable(of: AccessTokenRefresh.self) { response in
					switch response.result {
					case .success(let result):
						UserDefaults.standard[.accessToken] = result.accessToken
						completionHandler()
					case .failure(_):
						break
					}
				}
		} catch {

		}
	}

//	 static func createLogin(query: LoginQuery) -> Single<LoginModel> {
//		  return Single<LoginModel>.create { single in
//				do {
//					 let urlRequest = try Router.login(query: query).asURLRequest()
//
//					 AF.request(urlRequest)
//						  .validate(statusCode: 200..<300)
//						  .responseDecodable(of: LoginModel.self) { response in
//								switch response.result {
//								case .success(let loginModel):
//									 single(.success(loginModel))
//								case .failure(let error):
//									 single(.failure(error))
//								}
//						  }
//				} catch {
//					 single(.failure(error))
//				}
//
//				return Disposables.create()
//		  }
//	 }




}
