import XCTest
@testable import StorjHolder

class StorjHolderTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(StorjHolder().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
