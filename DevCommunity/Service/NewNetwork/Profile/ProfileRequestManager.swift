//
//  ProfileRequestManager.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/10/24.
//

import Foundation
import Moya
import RxSwift

final class ProfileRequestManager: BaseRequestManager {
	var provider = MoyaProvider<ProfileRouter>(session: Session(interceptor: Interceptor.shared), plugins: [MoyaLogger(), MoyaCacheablePlugin()])

	func putProfileEdit(query: ProfileEditModel) -> Single<Result<ProfileEditModel, Error>> {
		return Single<Result<ProfileEditModel, Error>>.create { single in
			self.provider.request(.profileEdit(query: query)) { response in
				self.requestHandling(single, response: response)
			}
			return Disposables.create()
		}
	}

	func getMyProfile() -> Single<Result<ProfileResultModel, Error>> {
		return Single<Result<ProfileResultModel, Error>>.create { single in
			self.provider.request(.getMyProfile) { response in
				self.requestHandling(single, response: response)
			}
			return Disposables.create()
		}
	}
}
