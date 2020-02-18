# UIKit Viewer

## Description

- UIKit Framework에 있는 UI 객체들의 속성과, 그 속성을 변경했을 때 UI 변화를 관찰할 수 있는 공부용 앱
- iOS 개발을 처음 배우는 사람들이 **'UIKit에서 사용할 수 있는 객체들에 어떤 것이 있는지' ** 쉽게 찾아보고 Xcode 없이도 스마트폰에서 간단하게 UI 개발을 연습할 수 있도록 개발
- UI 객체의 속성값을 조절하면 실시간으로 UI가 변화하여 **'어떤 UI의 어떤 속성을 어떻게 설정하면 어떤 모습으로 변한다'**는 것을 한눈에 관찰할 수 있다
- 각 UI에서 더 다양한 property를 설정할 수 있도록 controller를 추가하고 UX를 향상시키는 등 보완해 나갈 계획

<p align="center">
  <img src="images/UIKitViewer-description.png" alt="Page Description" width="90%">
</p>

## Using Skills

- Swift

## Architecture

- 프로젝트 유지보수성을 향상시키기 위해 **MVC Pattern** 적용 시도
- **Delegate Pattern**을 사용하여 custom cell에서 발생한 사용자 입력을 controller로 전달하여 display view로 update

<p align="center">
  <img src="images/architecture.png" alt="Page Description" width="100%">
</p>
## Trouble Shooting

- `UIView.ContentMode`같이 몇 가지 case 중에서 하나를 선택해야 하는 `enum` 타입의 property에 대해 controller를 추가할 때, UIKit Framework에서 미리 정의된 불특정 다수의 `enum`타입의 모든 `case`를 일일이 파악해야 하는 어려움

  - `enum`에 `CaseIterable` protocol을 채택했을 때 컴파일러가 자동으로 생성하고 구현해주는 `allCases` property를 사용하여 `enum`의 모든 case들을 순회함. 단, UIKit에서 이미 선언되어 있는 `enum`에 대해 `CaseIterable`을 구현할 때는 `allCases`를 직접 구현해야 함
  - `CaseIterable`을 채택하는 `enum`에 대해 각 `case`들을  `String`타입으로 변환시키는 interface를 추가할 수 있도록 별도의 protocol 사용

  ```swift
  protocol EnumerationExtension: CaseIterable {
    var stringRepresentation: String { get }
  }
  
  extension UITableView.Style: EnumerationExtension {
    public typealias AllCases = [Self]
    public static var allCases: [Self] {
      return [
        .plain,
        .grouped,
        .insetGrouped,
      ]
    }
    var stringRepresentation: String {
      switch self {
      case .grouped:        return "grouped"
      case .insetGrouped:   return "insetGrouped"
      case .plain:          return "plain"
      @unknown default:
        fatalError("UITableView.Style: Unknown Case")
      }
    }
  }
  
  // Usage
  cases = UITableView.Style.allCases.map { $0.stringRepresentation }
  ```

## What's New

- [Swift Metatype 정리](https://cskime.github.io/2020/02/swift/MetaType/)

- [CaseIterable Protocol 정리](https://cskime.github.io/2020/02/swift/CaseIterable/)