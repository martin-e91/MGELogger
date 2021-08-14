//
//  MGELogger
// 

import XCTest

@testable import MGELogger

final class LoggerConfigurationTests: XCTestCase {
  func testIsEqualConfigurations() {
    let sut = Logger.defaultConfiguration

    XCTAssertTrue(sut.isEqual(to: Logger.defaultConfiguration))
    XCTAssertFalse(sut.isEqual(to: MockLoggerConfiguration()))
  }
}

// MARK: - Helpers

private extension LoggerConfigurationTests {
  struct MockLoggerConfiguration: LoggerConfiguration {
    var destination: Logger.Log.Destination { .console }

    var truncatingToken: String { "..." }
    
    var minimumLogLevel: Logger.Log.Level = .error
    
    var maxMessagesLength: UInt = 100
    
    var timestampFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.locale = Locale(identifier: "IT_it")
      formatter.timeZone = TimeZone(identifier: "US_us")
      formatter.dateFormat = "dd MM yyyy"
      return formatter
    }()
  }
}
