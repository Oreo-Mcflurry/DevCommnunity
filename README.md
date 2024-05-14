![Group 10324](https://github.com/Oreo-Mcflurry/DevCommnunity/assets/96654328/87b391de-935b-4c4d-8ce2-4bc676ee1c4e)

## [미출시] 데브커뮤니티 | 2024.04.10 ~ 2024.5.5 (26일)

<aside>
⭐ 해커톤, 개발자 행사는 데브커뮤니티에서.

해커톤같은 개발자 행사에 같이 나갈 팀원을 구하는 앱 입니다. 개발자 행사들을 모아볼 수 있고, 손쉽게 구인 공고를올리거나 참가 신청을 할 수 있습니다.

</aside>

![Group 18](https://github.com/Oreo-Mcflurry/DevCommnunity/assets/96654328/598c4142-7720-4520-9e46-300b366dff54)


### 🧑‍🤝‍🧑 팀, 프로젝트 구성

- 1인 개발
- iOS 16.0+

### 🔨 기술 스택 및 사용한 라이브러리

- UIKit / SnapKit
- SwiftUI
- MVVM
- RxSwift
- Input / Output Pattern
- Moya
- Skeleton UI
- RxDataSource
- Iamport-iOS

### 🥕 기능

- 로그인 / 회원가입
- 개발자 행사 정보 받아오기
- 같이 할 팀원 구하기
- 참가 신청
- 결제 기능

### 👏 해당 기술을 사용하며 이룬 성과

- RxDataSource와 SkeletonUI를 활용해 사용자 경험 향상
- Moya와 Router Pattern을 이용한 Alamofire 추상화
- Moya Interceptor를 이용한 AccessToken 관리
- Iamport를 이용한 결제, 결제 검증 및 에러 핸들링

### 🌠 Trouble Shooting

- Access Token이 만료 되었을 때, 기존에는 각 Requst 메서드마다 실패시 토큰을 다시 발급받도록 하였는데, Moya의 Interceptor를 적용하여 효율적으로 리프레시 토큰을 관리.
#### 이전 코드
~~~swift
func getPosts(query: PostsKind) -> Observable<EventPostsResultModel> {
    let request = PostsRequestModel(next: "", product_id: query.requestValue)
    return Observable.create { observer -> Disposable in
        self.callRequest(.getPost(query: request), type: EventPostsResultModel.self)
            .subscribe { event in
                switch event {
                case .success(let result):
                    observer.onNext(result)

                case .failure(_):
                    self.refreshAccessToken {
                        self.callRequest(.getPost(query: request), type: EventPostsResultModel.self)
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
~~~

#### 수정 후 코드
~~~swift
extension Interceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        return completion(.success(urlRequest))
    }

    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        let requestManager = AuthRequestManager()

        guard let response = request.response else {
            completion(.doNotRetryWithError(error))
            return
        }

        if response.statusCode != 401 || response.statusCode != 418 {
            completion(.doNotRetryWithError(error))
            return
        }

        requestManager.accessTokenRequest()
            .subscribe { response in
                switch response {
                case .success(let result):
                    switch result {
                    case .success(let accessToken):
                        UserDefaults.standard[.accessToken] = accessToken.accessToken
                        completion(.retry)
                    case .failure(let error):
                        completion(.doNotRetryWithError(error))
                    }
                case .failure(let error):
                    completion(.doNotRetryWithError(error))
                }
            }.disposed(by: disposeBag)
    }
}

~~~

- 자동 로그인을 구현하기 위해 최초 앱 진입시 RefreshToken으로 AccessToken을 발급받고, RefreshToken이 만료 되었을때 다시 로그인하도록 처리하였음

~~~swift
output.outputLoginResult
    .drive(with: self) { owner, value in
        let vc = value ? TabbarViewController() : UINavigationController(rootViewController: SignInViewController())
        owner.view?.window?.rootViewController = vc
    }.disposed(by: disposeBag)

~~~

- NavigationLink에서 Destination을 미리 초기화 해서 갖고 있어 뷰에 들어올때마다 실행되어야하는 메서드들이 실행이 안되었고, NavigationLazyView라는 뷰를 만들어 Lazy한 Navigation을 구현
#### 이전 코드
~~~swift
private var iamportPayView: some View {
    NavigationLink {
        IamportPaymentViewController().toSwiftUIView()
    } label: {
        Label(
            title: { Text("광고 제거 구매 (100원)") },
            icon: { Image(systemName: "person.fill").foregroundStyle(.cyan) }
        )
    }
}
~~~

#### 수정 후 코드
~~~swift
struct NavigationLazyView<T: View>: View {
    let build: () -> T
    init(_ build: @autoclosure @escaping () -> T) {
        self.build = build
    }
    var body: some View {
        build()
    }
}

private var iamportPayView: some View {
    NavigationLink {
        NavigationLazyView(IamportPaymentViewController().toSwiftUIView())
    } label: {
        Label(
            title: { Text("광고 제거 구매 (100원)") },
            icon: { Image(systemName: "person.fill").foregroundStyle(.cyan) }
        )
    }
}
~~~

- 자연스러운 애니메이션과 사용자 경험 향상을 위하여 SkeletionView와 RxDataSource를 사용였음.

~~~swift
let dataSource = RxTableViewSectionedAnimatedDataSource<DetailViewSectionModel>(animationConfiguration: AnimationConfiguration(insertAnimation: .fade)) { data, tableView, indexPath, item in

    if data[indexPath.section].row == .empty {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.identifier, for: indexPath) as? EmptyTableViewCell else { fatalError() }
        tableView.visibleCells.forEach { $0.hideSkeleton() }
        tableView.separatorStyle = .none
        return cell
    }

    guard let cell = tableView.dequeueReusableCell(withIdentifier: PartyTableViewCell.identifier, for: indexPath) as? PartyTableViewCell else { fatalError() }

    if data[indexPath.section].row == .data {
        cell.configureUI(item)
        cell.bookmarkButton.rx.tap.map { item }
            .bind(to: inputBookMarkCellButton)
            .disposed(by: cell.disposeBag)
    } else {
        cell.configureSkeleton()
    }

    return cell
}
~~~

### 🗂️ 폴더 구조

~~~
📦DevCommunity
 ┣ 📂Enum
 ┣ 📂Extension
 ┣ 📂Model
 ┃ ┣ 📂Codable
 ┃ ┣ 📂Decoding
 ┃ ┣ 📂Encoding
 ┃ ┗ 📂SectionModel
 ┣ 📂Protocol
 ┣ 📂Scene
 ┃ ┣ 📂AccountSettingScene
 ┃ ┣ 📂Base
 ┃ ┣ 📂DetailScene
 ┃ ┣ 📂EventsScene
 ┃ ┣ 📂IamportPaymentViewScene
 ┃ ┣ 📂InitialScene
 ┃ ┣ 📂PartyDetailScene
 ┃ ┣ 📂PartyJoinView
 ┃ ┣ 📂PartyPostAddScene
 ┃ ┣ 📂ProfileSettingScene
 ┃ ┣ 📂SettingScene
 ┃ ┣ 📂SignInScene
 ┃ ┣ 📂SignUpBottomSheet
 ┃ ┣ 📂SignUpCompleteScene
 ┃ ┣ 📂SignUpScene
 ┃ ┣ 📂TabbarScene
 ┃ ┣ 📂WebScene
 ┣ 📂Service
 ┃ ┣ 📂APIKey
 ┃ ┣ 📂Network
 ┃ ┃ ┣ 📂Router
 ┃ ┣ 📂NewNetwork
 ┃ ┃ ┣ 📂Auth
 ┃ ┃ ┣ 📂Base
 ┃ ┃ ┣ 📂Pay
 ┃ ┃ ┣ 📂Plugin
 ┃ ┃ ┃ ┣ 📂Cache
 ┃ ┃ ┃ ┣ 📂Interceptor
 ┃ ┃ ┃ ┗ 📂Logger
 ┃ ┃ ┣ 📂Post
 ┃ ┃ ┗ 📂Profile
 ┣ 📂View
 ┃ ┣ 📂BasePaddingLabel
 ┃ ┣ 📂BaseStepperView
 ┃ ┣ 📂CheckBoxView
 ┃ ┣ 📂CodeView
 ┃ ┣ 📂NavigationLazyView
 ┃ ┣ 📂SignUpLabelsView
 ┃ ┣ 📂SignUpTextFieldView
 ┗ ┗ 📂TitleView
~~~

### 📺 앱 구동 화면

| 뷰 | 이미지 |
| --- | --- |
| 로그인 뷰 | <img src="https://github.com/Oreo-Mcflurry/DevCommnunity/assets/96654328/ab2a7683-7730-4313-9569-e577d9e1ece9" width="188" height="408"> |
| 회원가입 뷰 | <img src="https://github.com/Oreo-Mcflurry/DevCommnunity/assets/96654328/eb702933-68b0-4766-831c-f77d7f5d2e49" width="188" height="408"> |
| 메인 뷰 | <img src="https://github.com/Oreo-Mcflurry/DevCommnunity/assets/96654328/27802b62-4cba-4448-bdd5-392378ea274a" width="188" height="408"> |
| 행사 상세 뷰 | <img src="https://github.com/Oreo-Mcflurry/DevCommnunity/assets/96654328/e7578e8f-2918-43cf-a2ef-c113f245e0c6" width="188" height="408"> |
| 팀원 구인글 작성 뷰 | <img src="https://github.com/Oreo-Mcflurry/DevCommnunity/assets/96654328/3593f0be-ff68-4e8d-8658-c51be08c1253" width="188" height="408"> |
| 팀원 구인글 참가 뷰 | <img src="https://github.com/Oreo-Mcflurry/DevCommnunity/assets/96654328/3a564d36-33bc-4b8e-834f-5aa0e0804148" width="188" height="408"> |
| 광고 제거 구매 뷰 | <img src="https://github.com/Oreo-Mcflurry/DevCommnunity/assets/96654328/04b6f647-c65d-414e-895c-752bca89c26a" width="188" height="408"> |



