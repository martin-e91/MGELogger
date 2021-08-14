//
//  MGELogger
// 

import XCTest

@testable import MGELogger

final class LogLevelTests: XCTestCase {
  func testSeverityCompare() {
    XCTAssertEqual(Logger.LogLevel.info, .info)
    XCTAssertLessThan(Logger.LogLevel.trace, .debug)
    XCTAssertLessThan(Logger.LogLevel.debug, .info)
    XCTAssertLessThan(Logger.LogLevel.info, .warning)
    XCTAssertLessThan(Logger.LogLevel.warning, .error)
  }
  
  func testSeverityValue() {
    XCTAssertEqual(Logger.LogLevel.trace.rawValue, 0)
    XCTAssertEqual(Logger.LogLevel.debug.rawValue, 1)
    XCTAssertEqual(Logger.LogLevel.info.rawValue, 2)
    XCTAssertEqual(Logger.LogLevel.warning.rawValue, 3)
    XCTAssertEqual(Logger.LogLevel.error.rawValue, 4)
  }

  func testTokensValue() {
    XCTAssertEqual(Logger.LogLevel.trace.token, "🤔 TRACE")
    XCTAssertEqual(Logger.LogLevel.debug.token, "🐞 DEBUG")
    XCTAssertEqual(Logger.LogLevel.info.token, "ℹ️ INFO")
    XCTAssertEqual(Logger.LogLevel.warning.token, "⚠️ WARNING")
    XCTAssertEqual(Logger.LogLevel.error.token, "⛔️ ERROR")
  }
}
