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
    XCTAssertEqual(sut.truncatingToken, expectedConfiguration.truncatingToken)
    XCTAssertTrue(sut.logHandler is StandardOutputLogHandler)
  }
  
  func testLowerLogLevel() {
    let sut = Logger(with: MockLoggerConfiguration())
    
    precondition(sut.minimumLogLevel == .trace)
    
    sut.change(minimumLogLevel: .info)
    
    XCTAssertEqual(sut.minimumLogLevel, .info)
  }
  
  func testBumpLogLevel() {
    let sut = Logger(with: MockLoggerConfiguration())
    
    precondition(sut.minimumLogLevel == .trace)
    
    sut.change(minimumLogLevel: .error)
    
    XCTAssertEqual(sut.minimumLogLevel, .error)
  }
  
  func testChangeWithSameLogLevel() {
    let sut = Logger(with: MockLoggerConfiguration())
    
    precondition(sut.minimumLogLevel == .trace)
    
    sut.change(minimumLogLevel: .trace)
    
    XCTAssertEqual(sut.minimumLogLevel, .trace)
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
  
  func testTraceMessage() throws {
    let mockLogHandler = MockLogHandler()

    let sut = Logger(with: MockLoggerConfiguration(with: .custom(receiver: mockLogHandler)))
    sut.trace(title: "EXAMPLE_TITLE", message: "EXAMPLE_MESSAGE")
    
    XCTAssertTrue(sut.logHandler is MockLogHandler)
    XCTAssertEqual(mockLogHandler.messages.count, 1)
    let resultMessage = try XCTUnwrap(mockLogHandler.messages.first)
    let timestamp = Self.dateFormatter.string(from: Date())
    
    XCTAssertEqual(resultMessage, "[\(timestamp)] 🤔 TRACE: LoggerTests.swift:81: testTraceMessage():\nEXAMPLE_TITLE: EXAMPLE_MESSAGE\n")
  }
  
  func testDebugMessage() throws {
    let mockLogHandler = MockLogHandler()

    let sut = Logger(with: MockLoggerConfiguration(with: .custom(receiver: mockLogHandler)))
    sut.debug(title: "EXAMPLE_TITLE", message: "EXAMPLE_MESSAGE")
    
    XCTAssertTrue(sut.logHandler is MockLogHandler)
    XCTAssertEqual(mockLogHandler.messages.count, 1)
    let resultMessage = try XCTUnwrap(mockLogHandler.messages.first)
    let timestamp = Self.dateFormatter.string(from: Date())
    XCTAssertEqual(resultMessage, "[\(timestamp)] 🐞 DEBUG: LoggerTests.swift:95: testDebugMessage():\nEXAMPLE_TITLE: EXAMPLE_MESSAGE\n")
  }
  
  func testInfoMessage() throws {
    let mockLogHandler = MockLogHandler()

    let sut = Logger(with: MockLoggerConfiguration(with: .custom(receiver: mockLogHandler)))
    sut.info(title: "EXAMPLE_TITLE", message: "EXAMPLE_MESSAGE")
    
    XCTAssertTrue(sut.logHandler is MockLogHandler)
    XCTAssertEqual(mockLogHandler.messages.count, 1)
    let resultMessage = try XCTUnwrap(mockLogHandler.messages.first)
    let timestamp = Self.dateFormatter.string(from: Date())
    XCTAssertEqual(resultMessage, "[\(timestamp)] ℹ️ INFO: LoggerTests.swift:108: testInfoMessage():\nEXAMPLE_TITLE: EXAMPLE_MESSAGE\n")
  }
  
  func testWarningMessage() throws {
    let mockLogHandler = MockLogHandler()

    let sut = Logger(with: MockLoggerConfiguration(with: .custom(receiver: mockLogHandler)))
    sut.warning(title: "EXAMPLE_TITLE", message: "EXAMPLE_MESSAGE")
    
    XCTAssertTrue(sut.logHandler is MockLogHandler)
    XCTAssertEqual(mockLogHandler.messages.count, 1)
    let resultMessage = try XCTUnwrap(mockLogHandler.messages.first)
    let timestamp = Self.dateFormatter.string(from: Date())
    XCTAssertEqual(resultMessage, "[\(timestamp)] ⚠️ WARNING: LoggerTests.swift:121: testWarningMessage():\nEXAMPLE_TITLE: EXAMPLE_MESSAGE\n")
  }
  
  func testErrorMessage() throws {
    let mockLogHandler = MockLogHandler()

    let sut = Logger(with: MockLoggerConfiguration(with: .custom(receiver: mockLogHandler)))
    sut.error(title: "EXAMPLE_TITLE", message: "EXAMPLE_MESSAGE")
    
    XCTAssertTrue(sut.logHandler is MockLogHandler)
    XCTAssertEqual(mockLogHandler.messages.count, 1)
    let resultMessage = try XCTUnwrap(mockLogHandler.messages.first)
    let timestamp = Self.dateFormatter.string(from: Date())
    XCTAssertEqual(resultMessage, "[\(timestamp)] ⛔️ ERROR: LoggerTests.swift:134: testErrorMessage():\nEXAMPLE_TITLE: EXAMPLE_MESSAGE\n")
  }
}

// MARK: - Helpers

private extension LoggerTests {
  static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "IT_it")
    formatter.timeZone = TimeZone(identifier: "US_us")
    formatter.dateFormat = "dd MM yyyy"
    return formatter
  }()

  struct MockLoggerConfiguration: LoggerConfiguration {
    let destination: Logger.Log.Destination

    var truncatingToken: String { "..." }
    
    var minimumLogLevel: Logger.Log.Level = .trace
    
    var maxMessagesLength: UInt = 10000
    
    let timestampFormatter: DateFormatter = dateFormatter
    
    init(with destination: Logger.Log.Destination = .console) {
      self.destination = destination
    }
  }
}
