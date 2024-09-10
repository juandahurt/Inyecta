import XCTest
@testable import Inyecta

final class InyectaTests: XCTestCase {
    var container: Container!
    
    override func setUp() {
        container = Container()
    }
    
    func testContainer_afterRegisterAService_shouldReturnService() throws {
        container.register {
            Mock()
        }
        let mock = container.resolve(Mock.self)
        XCTAssertNotNil(mock)
    }
    
    func testResolve_whenRegisteringAsFactory_shouldReturnDifferentInstances() {
        container.register(.factory) {
            MockClass()
        }
        
        guard let firstInstance = container.resolve(MockClass.self) else {
            XCTFail("instance was not found")
            return
        }
        guard let secondInstance = container.resolve(MockClass.self) else {
            XCTFail("instance was not found")
            return
        }
        
        XCTAssertNotEqual(firstInstance.id, secondInstance.id)
    }
    
    func testResolve_whenRegisteringAsSingleton_shouldReturnTheSameInstace() {
        container.register(.singleton) {
            MockClass()
        }
        
        guard let firstInstance = container.resolve(MockClass.self) else {
            XCTFail("instance was not found")
            return
        }
        guard let secondInstance = container.resolve(MockClass.self) else {
            XCTFail("instance was not found")
            return
        }
        
        XCTAssertEqual(firstInstance.id, secondInstance.id)
    }
}

// MARK: - Helper
struct Mock {
    var mock = "hi"
}


class MockClass {
    let id = UUID().uuidString
}
