![Group 10324](https://github.com/Oreo-Mcflurry/DevCommnunity/assets/96654328/87b391de-935b-4c4d-8ce2-4bc676ee1c4e)

## [미출시] 데브커뮤니티 | 2024.04.10 ~ 2024.5.5 (26일)

<aside>
⭐ 해커톤, 개발자 행사는 데브커뮤니티에서.

해커톤같은 개발자 행사에 같이 나갈 팀원을 구하는 앱 입니다. 개발자 행사들을 모아볼 수 있고, 손쉽게 구인 공고를올리거나 참가 신청을 할 수 있습니다.

</aside>

![Group 10325](https://github.com/Oreo-Mcflurry/DevCommnunity/assets/96654328/899f6b76-426a-482a-976c-3de40aa95b4b)

## 🧑‍🤝‍🧑 팀구성

- 1인 개발

### 🔨 기술 스택 및 사용한 라이브러리

- UIKit / SnapKit
- SwiftUI
- MVVM
- RxSwift
- Input / Output Pattern
- Alamofire / Moya
- Skeleton UI
- RxDataSource
- Toast
- Iamport-iOS

### 👏 해당 기술을 사용하며 이룬 성과

- RxDataSource와 SkeletonUI를 활용해 사용자 경험 향상
- Moya와 Router Pattern을 이용한 Alamofire 추상화
- Moya Interceptor를 이용한 AccessToken 관리
- Iamport를 이용한 결제, 결제 검증 및 에러 핸들링

### 🌠 Trouble Shooting

- Access Token을 효율적으로 관리 하기 위해 Moya의 Interceptor의 retry 메서드를 이용
- NavigationLink에서 Destination을 미리 초기화 해서 갖고 있어 뷰에 들어올때마다 실행되어야하는 메서드들이 실행이 안되었고, NavigationLazyView라는 뷰를 만들어 Lazy한 Navigation을 구현
