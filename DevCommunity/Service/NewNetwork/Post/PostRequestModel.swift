//
//  PostRequestModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/3/24.
//

import Foundation
import Moya
import RxSwift

final class PostRequestManager {

	 private var provider = MoyaProvider<PostRouter>(session: Session(interceptor: Interceptor.shared))

	 func getPosts(query: PostsRequestModel) -> Single<Result<EventPostsResultModel, Error>> {
		  return Single<Result<EventPostsResultModel, Error>>.create { single in
				self.provider.request(.getPost(query: query)) { response in
					 switch response {
					 case .success(let result):
						  do {
							  let posts = try result.map(EventPostsResultModel.self)
								single(.success(.success(posts)))
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

	 func getPartyPosts(query: PostsRequestModel) -> Single<Result<PartyPostsResultModel, Error>> {
		  return Single<Result<PartyPostsResultModel, Error>>.create { single in
				self.provider.request(.getPartyPost(query: query)) { response in
					 switch response {
					 case .success(let result):
						  do {
								let posts = try result.map(PartyPostsResultModel.self)
								single(.success(.success(posts)))
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

	 func likePost(postID: String, query: LikeRequestModel) -> Single<Result<LikeResultModel, Error>> {
		  return Single<Result<LikeResultModel, Error>>.create { single in
				self.provider.request(.like(postID: postID, query: query)) { response in
					 switch response {
					 case .success(let result):
						 do {
							  let like = try result.map(LikeResultModel.self)
							  single(.success(.success(like)))
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
