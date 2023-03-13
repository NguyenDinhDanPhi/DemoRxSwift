import UIKit
import RxSwift
import RxRelay
// 1
enum MyError: Error {
    case anError
}

func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
  print(label, (event.element ?? event.error) ?? event)
}

let relay = BehaviorRelay(value: "Initial value")
 let disposeBag = DisposeBag()

 // 2
 relay.accept("New initial value")
relay
    .subscribe {
      print(label: "1)", event: $0)
    }
    .disposed(by: disposeBag)
// 1
relay.accept("1")

// 2
relay
  .subscribe {
    print(label: "2)", event: $0)
  }
  .disposed(by: disposeBag)

// 3
relay.accept("2")
relay.accept("3")
print(relay.value)
