import XCTest
@testable import Inyecta

final class InyectaTests: XCTestCase {
    func testExample() throws {
        let container = Container()
        container.register {
            Mock()
        }
        let mock = container.resolve(Mock.self)
        mock?.hi()
    }
}


struct Mock {
    func hi() {
        print("Hello!")
    }
}
