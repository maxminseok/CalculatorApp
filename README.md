# 🔎프로젝트 소개
간단한 약식 계산기 앱 만들기
  - 소수점을 고려하지 않은, 정수형 계산만 하며
   - 모든 연산 버튼을 클릭할때마다 계산이 이루어지도록 하지는 않으며
   - 등호 버튼 (=) 을 클릭했을 때만 연산이 이루어지도록 합니다.
   - 수식 문자열이 들어왔을 때 이를 계산해주는 Swift 의 기본 제공 기능을 활용합니다.

---

## 📌요구 사항
+ Lv 1 : ``UILabel`` 을 사용해서 수식을 표시할 수 있는 라벨을 띄우기
+ Lv 2 : ``UIStackView`` 을 사용해서 4개의 버튼을 모아 가로 스택뷰 생성
+ Lv 3 : ``UIStackView`` 을 사용해서 세로 스택 뷰 생성
+ Lv 4 : 연산 버튼 (+, -, *, /, AC, =) 들은 색상을 **orange** 로 설정
+ Lv 5 : 모든 버튼들을 원형으로 만들기
+ Lv 6 : 버튼을 클릭하면 라벨에 표시
+ Lv 7 : 초기화 버튼 (AC) 을 구현
+ Lv 8 : 등호 (=) 버튼을 클릭하면 연산이 수행되도록 구현

---

## 📖파일 구성
### Model 폴더
입력을 계산할 Calculator 클래스가 구현되어 있는 폴더입니다.

### View 폴더
UI 생성과 관리를 위한 클래스들이 구현되어 있는 폴더입니다.
+ ButtonMaker.swift : UIButton 생성을 위한 클래스가 구현되어 있습니다.
+ LabelMaker.swift : UILabel 생성을 위한 클래스가 구현되어 있습니다.
+ StackViewMaker.swift : UIStackView 생성을 위한 클래스가 구현되어 있습니다.
+ LabelManager.swift : button 클릭시 변할 label의 값을 관리하기 위한 클래스가 구현되어 있습니다.
+ UIConfigurator.swift : ViewController에 UI 생성을 하기 위한 클래스가 구현되어 있습니다.

### Controller 폴더
UI를 구성하고, button 클릭 이벤트 처리를 위한 메서드가 구현되어 있습니다.

---

## 🙏커밋 컨벤션
- [ADD] : 파일 추가
- [RENAME] : 파일 혹은 폴더명을 수정하거나 옮기는 작업만인 경우 
- [REMOVE] : 파일을 삭제하는 작업만 수행한 경우 
- [FEAT] : 기능 추가 
- [DELETE] : 기능 삭제 
- [UPDATE] : 기능 수정 
- [FIX] : 버그 수정 
- [REFACTOR] : 리팩토링 
- [STYLE] : 스타일 (코드 형식, 세미콜론 추가: 비즈니스 로직에 변경 없음)
- [CHORE] : 기타 변경사항 (빌드 스크립트 수정, 에셋 추가 등)
- [DESIGN] : 사용자 UI 디자인 변경
- [HOTFIX] : 급하게 치명적인 버그를 고쳐야하는 경우
- [COMMENT] : 필요한 주석 추가 및 변경

---

## 트러블 슈팅
[🛠️트러블슈팅](https://velog.io/@maxminseok/TIL-%EA%B3%BC%EC%A0%9C-%EA%B3%84%EC%82%B0%EA%B8%B0-%EC%95%B1-%EB%A9%94%EC%84%9C%EB%93%9C-%EB%B6%84%EB%A6%AC%ED%95%98%EA%B8%B0)
