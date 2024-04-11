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

struct LoginModel: Decodable {
	 let token: String
	 let refreshToken: String
}

struct NetworkManager {

	 static func createLogin(query: LoginQuery) -> Single<LoginModel> {
		  return Single<LoginModel>.create { single in
				do {
					 let urlRequest = try Router.login(query: query).asURLRequest()

					 AF.request(urlRequest)
						  .validate(statusCode: 200..<300)
						  .responseDecodable(of: LoginModel.self) { response in
								switch response.result {
								case .success(let loginModel):
									 single(.success(loginModel))
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
}
