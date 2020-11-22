import XCTest
@testable import MGELogger

final class MGELoggerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MGELogger().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
