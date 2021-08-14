//
//  MGELogger
// 

import XCTest

@testable import MGELogger

final class LoggerTests: XCTestCase {
  func testInitWithConfigurationCorrectness() {
    let mockConfiguration = MockLoggerConfiguration()
    
    let sut = Logger(configuration: mockConfiguration)
    
    XCTAssertEqual(sut.maxMessagesLength, mockConfiguration.maxMessagesLength)
    XCTAssertEqual(sut.minimumLogLevel, mockConfiguration.minimumLogLevel)
    XCTAssertEqual(sut.timestampFormatter, mockConfiguration.timestampFormatter)
  }
}

// MARK: - Helpers

private extension LoggerTests {
  struct MockLoggerConfiguration: LoggerConfiguration {
    var minimumLogLevel: Logger.LogLevel = .error
    
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
