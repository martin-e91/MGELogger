//
//  MGELogger
// 

import XCTest

@testable import MGELogger

final class ContextTests: XCTestCase {
  func testContextDescriptionValue() {
    let context = Logger.Context(logLevel: .info, timestamp: "mockTimestamp", filePath: #file, line: #line, function: #function)

    XCTAssertEqual(context.description, "[mockTimestamp] ℹ️ INFO: ContextTests.swift:11: testContextDescriptionValue()")
  }
}
