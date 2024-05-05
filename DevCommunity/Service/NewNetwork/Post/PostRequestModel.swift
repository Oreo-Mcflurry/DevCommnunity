//
//  PostRequestModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/3/24.
//

import Foundation
import Moya
import RxSwift

final class PostRequestManager: BaseRequestManager {

	private var provider = MoyaProvider<PostRouter>(session: Session(interceptor: Interceptor.shared), plugins: [MoyaLogger(), MoyaCacheablePlugin()])

	func getEventPosts() -> Single<Result<EventPostsResultModel, Error>> {
		let query = PostsRequestModel(next: "", product_id: "DevCommunity")
		return Single<Result<EventPostsResultModel, Error>>.create { single in
			self.provider.request(.getPost(query: query)) { response in
				self.requestHandling(single, response: response)
			}
			return Disposables.create()
		}
	}

	func getPartyPosts(query: PostsRequestModel) -> Single<Result<PartyPostsResultModel, Error>> {
		return Single<Result<PartyPostsResultModel, Error>>.create { single in
			self.provider.request(.getPartyPost(query: query)) { response in
				self.requestHandling(single, response: response)
			}
			return Disposables.create()
		}
	}

	func likePost(postID: String, query: LikeRequestModel) -> Single<Result<LikeResultModel, Error>> {
		return Single<Result<LikeResultModel, Error>>.create { single in
			self.provider.request(.like(postID: postID, query: query)) { response in
				self.requestHandling(single, response: response)
			}
			return Disposables.create()
		}
	}

	func writePost(data: WritePostRequestModel) -> Single<Result<PartyPost, Error>> {
		return Single<Result<PartyPost, Error>>.create { single in
			self.provider.request(.writePost(data: data)) { response in
				self.requestHandling(single, response: response)
			}
			return Disposables.create()
		}
	}
}

extension PostRequestManager: MoyaCacheable {
	var cachePolicy: MoyaCacheablePolicy {
		return .reloadIgnoringLocalCacheData
	}
}
