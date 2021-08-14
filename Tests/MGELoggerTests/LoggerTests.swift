//
//  MGELogger
// 

import XCTest

@testable import MGELogger

final class LoggerTests: XCTestCase {
  override func setUp() {
    Logger.resetConfigurationAndEnableLogger()
  }
  
  func testInitWithConfigurationCorrectness() {
    let mockConfiguration = MockLoggerConfiguration()

    let sut = Logger.self
    sut.apply(configuration: mockConfiguration)
    
    XCTAssertEqual(sut.maxMessagesLength, mockConfiguration.maxMessagesLength)
    XCTAssertEqual(sut.minimumLogLevel, mockConfiguration.minimumLogLevel)
    XCTAssertEqual(sut.timestampFormatter, mockConfiguration.timestampFormatter)
  }
  
  func testDisableLogger() {
    let sut = Logger.self
    
    XCTAssertTrue(sut.isEnabled)
    sut.disable()
    XCTAssertFalse(sut.isEnabled)
  }
  
  func testEnableLogger() {
    let sut = Logger.self
    
    XCTAssertTrue(sut.isEnabled)
    sut.enable()
    XCTAssertTrue(sut.isEnabled)
  }
  
  func testIsDisabled() {
    let sut = Logger.self
    
    XCTAssertFalse(sut.isDisabled)
    sut.disable()
    XCTAssertTrue(sut.isDisabled)
    sut.enable()
    XCTAssertFalse(sut.isDisabled)
  }
  
  func testResetConfiguration() {
    let sut = Logger.self
    
    sut.apply(configuration: MockLoggerConfiguration())
  }
  
  func testEqualConfigurations() {
    let sut = Logger.defaultConfiguration

    XCTAssertTrue(sut.isEqual(to: Logger.defaultConfiguration))
    XCTAssertFalse(sut.isEqual(to: MockLoggerConfiguration()))
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
