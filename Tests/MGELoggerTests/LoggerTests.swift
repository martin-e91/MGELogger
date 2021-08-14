//
//  MGELogger
// 

import XCTest

@testable import MGELogger

final class LoggerTests: XCTestCase {
  func testInitWithConfigurationCorrectness() {
    let expectedConfiguration = MockLoggerConfiguration()
    let sut = Logger(with: expectedConfiguration)
    
    XCTAssertEqual(sut.maxMessagesLength, expectedConfiguration.maxMessagesLength)
    XCTAssertEqual(sut.minimumLogLevel, expectedConfiguration.minimumLogLevel)
    XCTAssertEqual(sut.timestampFormatter, expectedConfiguration.timestampFormatter)
  }
  
  func testLowerLogLevel() {
    let sut = Logger(with: MockLoggerConfiguration())
    
    precondition(sut.minimumLogLevel == .warning)
    
    sut.change(minimumLogLevel: .info)
    
    XCTAssertEqual(sut.minimumLogLevel, .info)
  }
  
  func testBumpLogLevel() {
    let sut = Logger(with: MockLoggerConfiguration())
    
    precondition(sut.minimumLogLevel == .warning)
    
    sut.change(minimumLogLevel: .error)
    
    XCTAssertEqual(sut.minimumLogLevel, .error)
  }
  
  func testChangeWithSameLogLevel() {
    let sut = Logger(with: MockLoggerConfiguration())
    
    precondition(sut.minimumLogLevel == .warning)
    
    sut.change(minimumLogLevel: .warning)
    
    XCTAssertEqual(sut.minimumLogLevel, .warning)
  }
  
  func testDisableLogger() {
    let sut = Logger(with: MockLoggerConfiguration())
    
    XCTAssertTrue(sut.isEnabled)
    sut.disable()
    XCTAssertFalse(sut.isEnabled)
  }
  
  func testEnableLogger() {
    let sut = Logger(with: MockLoggerConfiguration())
    
    XCTAssertTrue(sut.isEnabled)
    sut.enable()
    XCTAssertTrue(sut.isEnabled)
  }
  
  func testIsDisabled() {
    let sut = Logger(with: MockLoggerConfiguration())
    
    XCTAssertFalse(sut.isDisabled)
    sut.disable()
    XCTAssertTrue(sut.isDisabled)
    sut.enable()
    XCTAssertFalse(sut.isDisabled)
  }
}

// MARK: - Helpers

private extension LoggerTests {
  struct MockLoggerConfiguration: LoggerConfiguration {
    var truncatingToken: String { "..." }
    
    var minimumLogLevel: Logger.Log.Level = .warning
    
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
