//
//  MGELogger
// 

import XCTest

@testable import MGELogger

final class LogLevelTests: XCTestCase {
  func testSeverityCompare() {
    XCTAssertEqual(Logger.Log.Level.info, .info)
    XCTAssertLessThan(Logger.Log.Level.trace, .debug)
    XCTAssertLessThan(Logger.Log.Level.debug, .info)
    XCTAssertLessThan(Logger.Log.Level.info, .warning)
    XCTAssertLessThan(Logger.Log.Level.warning, .error)
  }
  
  func testSeverityValue() {
    XCTAssertEqual(Logger.Log.Level.trace.rawValue, 0)
    XCTAssertEqual(Logger.Log.Level.debug.rawValue, 1)
    XCTAssertEqual(Logger.Log.Level.info.rawValue, 2)
    XCTAssertEqual(Logger.Log.Level.warning.rawValue, 3)
    XCTAssertEqual(Logger.Log.Level.error.rawValue, 4)
  }

  func testTokensValue() {
    XCTAssertEqual(Logger.Log.Level.trace.token, "🤔 TRACE")
    XCTAssertEqual(Logger.Log.Level.debug.token, "🐞 DEBUG")
    XCTAssertEqual(Logger.Log.Level.info.token, "ℹ️ INFO")
    XCTAssertEqual(Logger.Log.Level.warning.token, "⚠️ WARNING")
    XCTAssertEqual(Logger.Log.Level.error.token, "⛔️ ERROR")
  }
}
