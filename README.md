# 제로섬 
### # 세상의 모든 식음료를 담다
제로칼로리, 제로슈가 등 제로 식음료의 모든 정보! 최신 상품 및 몰랐던 제로 식음료부터 프랜차이즈 카페의 제로 메뉴까지, 건강한 선택을 지금 바로 확인하세요 :)



### Develpoment Environment
```
Minimum Deployments: iOS 16.0
Xocde Version: 15.0.1
Tuist Version: 3.7.0
```

**외부 라이브러리**
```
kakao-ios-sdk
KingFisher
Firebase
```

---
### Skill Stack
- Development: SwiftUI + Tuist
- Architecture : Clean Architecture + MVVM
- **✷ 현재 Tuist를 활용해 각 Layer 별 모듈화 작업중**

### Architecture 선정 이유
`의존성 관리`  
역할별로 명확한 layer를 구분하여 각 layer는 독립적으로 동작하기 때문에 특정 기능을 수정하거나 추가할때도 다른 layer에 영향을 주지않고 관련된 부분만 수정하면 됨

`변경 용이`  
프로토콜(인터페이스)를 사용함으로써 새로운 기능이나 모듈을 추가할 때, 기존 코드에 최소한의 영향을 주면서 쉬운 확장이 가능함

`확장성`  
DI를 통해 각 레이어는 프로토콜로(인터페이스) 소통하기 때문에 결합도가 낮아지며, 의존성 관리에 유연함  

`독립성`  
각 레이어의 독립적인 동작이 가능하기 때문에, UI나 데이터의 접근 방식이  변경되어도 도메인 레이어는 변경없이 사용할 수 있음  

`가독성`  
각 레이어의 책임을 명확하게 정의하고 역할을 분리하여 코드의 가독성을 높임
새로운 팀원이 프로젝트에 합류했을 때 쉽게 이해할 수 있음

<img src="https://raw.githubusercontent.com/zerosome-dev/zerosome-ios/refs/heads/dev/images/%EC%A0%9C%EB%A1%9C%EC%84%AC%20%EC%95%84%ED%82%A4%ED%85%8D%EC%B2%98.png" >

### Layer 구현 내용
`Application Layer`
- AppDelegate, SceneDelegate 위치  
- 애플리케이션의 진입점으로써 실행과 관련된 작업을 처리함 
- 다른 레이어 간의 의존성을 관리함  

`Data Layer`  
- 외부 데이터 소스와의 상호작용을 담당하는 레이어  
- APIService가 위치하며 네트워크 작업이 이루어짐  
- DTO로 받아오며 Mapper를 통해 앱 내부에 맞는 데이터로 변환하여 사용  

`Domain Layer`  
- 비즈니스 로직을 처리하는 핵심 레이어   
- Entity, Usecase, Repository Protocol 를 정의하고 사용  
- 외부 데이터 소스나 UI에 의존하지 않고 순수한 비즈니스 로직만을 포함함  

`Presentation Layer`  
- UI와 관련된 모든 요소를 처리하는 레이어  
- MVVM 패턴의 ViewModel이 포함됨  
- 사용자 인터페이스 로직을 처리하며 Domain레이어와 상호 작용을 통해 UI를 업데이트함  

`Design System Module`  
- 디자인과 관련된 파일, 소스들이 모여있는 모듈  
- 비즈니스 로직과 연관 없이 디자인만 정의되어 있는 모듈

---
### Main Features
- 로그인
    - 소셜로그인 지원 (카톡 / 애플)
    - 비로그인 지원 (비유저 앱 일부 접속 가능)
- 홈
    - 카테고리별 제로 식음료 모아보기
    - 제품 상세 확인
    - 출시 예정 상품 확인하기
- 카테고리
    - 탄산수/음료, 카페/음료, 과자/아이스크림 등, 중분류 카테고리 확인
    - 필터 기능을 통해 원하는 제로 식음료 검색 가능
        - 필터기능 (카테고리 / 브랜드 / 제로태그) 
        - 정렬 기능 (최신순 / 별점 높은순 / 별점 낮은 순 / 리뷰 많은순 / 리뷰 적은순)
    - 제품 상세 확인
- 제품 상세
    - 제품의 상세 정보 확인
        - 판매처, 제품 영양정보, 제품 별점 및 리뷰
- 마이페이지
    - 닉네임 수정
    - 작성한 리뷰 확인
    - 문의하기를 통해 메일 or 카카오 채널 채팅방으로 이동

---
### App Images

| `홈`                                                                                                                                 |                                                                             `카테고리 검색`                                                                                                                       |                                                                             `필터생성`                                                                                                                               | `필터상세`                                                                                                                               |                                                   `마이페이지`                                                                                                                             |
| ----------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://raw.githubusercontent.com/zerosome-dev/zerosome-ios/refs/heads/dev/images/IMG_4855.PNG" width="143" height="300"> | <img src="https://raw.githubusercontent.com/zerosome-dev/zerosome-ios/refs/heads/dev/images/IMG_4856.PNG" width="143" height="300"><br><br><br> | <img src="https://raw.githubusercontent.com/zerosome-dev/zerosome-ios/refs/heads/dev/images/IMG_4857.PNG " width="143" height="300"> | <img src="https://raw.githubusercontent.com/zerosome-dev/zerosome-ios/refs/heads/dev/images/IMG_4858.PNG " width="143" height="300"> | <img src="https://raw.githubusercontent.com/zerosome-dev/zerosome-ios/refs/heads/dev/images/IMG_4863.PNG" width="143" height="300"> |

|                                                               `제품상세1`                                                               |                                                               `제품상세2`                                                               |                                                                `리뷰`                                                                 |                                                               `리뷰작성`                                                               |                                                     `작성리뷰`                                                                                                                               |
| :---------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------: | ------------------------------------------------------------------------------------------------------------------------------------ |
| <img src="https://raw.githubusercontent.com/zerosome-dev/zerosome-ios/refs/heads/dev/images/IMG_4859.PNG" width="143" height="300"> | <img src="https://raw.githubusercontent.com/zerosome-dev/zerosome-ios/refs/heads/dev/images/IMG_4860.PNG" width="143" height="300"> | <img src="https://raw.githubusercontent.com/zerosome-dev/zerosome-ios/refs/heads/dev/images/IMG_4861.PNG" width="143" height="300"> | <img src="https://raw.githubusercontent.com/zerosome-dev/zerosome-ios/refs/heads/dev/images/IMG_4865.PNG" width="143" height="300"> | <img src="https://raw.githubusercontent.com/zerosome-dev/zerosome-ios/refs/heads/dev/images/IMG_4862.PNG " width="143" height="300"> |
