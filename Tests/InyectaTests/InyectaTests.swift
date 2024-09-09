import XCTest
@testable import Inyecta

final class InyectaTests: XCTestCase {
    func testContainer_afterRegisterAService_shouldReturnService() throws {
        let container = Container()
        container.register {
            Mock()
        }
        let mock = container.resolve(Mock.self)
        XCTAssertNotNil(mock)
    }
}

// MARK: - Helper
struct Mock {
    var mock = "hi"
}
