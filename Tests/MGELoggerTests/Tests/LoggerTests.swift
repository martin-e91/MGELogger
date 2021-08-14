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
  
  func testNoLogsWhenDisabled() {
    let mockLogHandler = MockLogHandler()

    let sut = Logger(with: MockLoggerConfiguration(with: .custom(receiver: mockLogHandler)))
    sut.disable()
    sut.trace(title: "EXAMPLE_TITLE", message: "EXAMPLE_MESSAGE")
    
    XCTAssertTrue(sut.logHandler is MockLogHandler)
    XCTAssertTrue(mockLogHandler.messages.isEmpty)
  }
  
  func testMultipleLogMessages() {
    let mockLogHandler = MockLogHandler()

    let sut = Logger(with: MockLoggerConfiguration(with: .custom(receiver: mockLogHandler)))

    for _ in 0..<3 {
      sut.trace(title: "", message: "")
    }
    
    XCTAssertTrue(sut.logHandler is MockLogHandler)
    XCTAssertEqual(mockLogHandler.messages.count, 3)
  }
  
  func testTraceMessage() throws {
    let mockLogHandler = MockLogHandler()

    let sut = Logger(with: MockLoggerConfiguration(with: .custom(receiver: mockLogHandler)))
    sut.trace(title: "EXAMPLE_TITLE", message: "EXAMPLE_MESSAGE")
    let expectedLine = #line - 1
    
    XCTAssertTrue(sut.logHandler is MockLogHandler)
    XCTAssertEqual(mockLogHandler.messages.count, 1)
    let resultMessage = try XCTUnwrap(mockLogHandler.messages.first)
    let timestamp = Self.dateFormatter.string(from: Date())
    
    XCTAssertEqual(resultMessage, "[\(timestamp)] 🤔 TRACE: LoggerTests.swift:\(expectedLine): testTraceMessage():\nEXAMPLE_TITLE:\nEXAMPLE_MESSAGE\n")
  }
  
  func testDebugMessage() throws {
    let mockLogHandler = MockLogHandler()

    let sut = Logger(with: MockLoggerConfiguration(with: .custom(receiver: mockLogHandler)))
    sut.debug(title: "EXAMPLE_TITLE", message: "EXAMPLE_MESSAGE")
    let expectedLine = #line - 1

    XCTAssertTrue(sut.logHandler is MockLogHandler)
    XCTAssertEqual(mockLogHandler.messages.count, 1)
    let resultMessage = try XCTUnwrap(mockLogHandler.messages.first)
    let timestamp = Self.dateFormatter.string(from: Date())
    XCTAssertEqual(resultMessage, "[\(timestamp)] 🐞 DEBUG: LoggerTests.swift:\(expectedLine): testDebugMessage():\nEXAMPLE_TITLE:\nEXAMPLE_MESSAGE\n")
  }
  
  func testInfoMessage() throws {
    let mockLogHandler = MockLogHandler()

    let sut = Logger(with: MockLoggerConfiguration(with: .custom(receiver: mockLogHandler)))
    sut.info(title: "EXAMPLE_TITLE", message: "EXAMPLE_MESSAGE")
    let expectedLine = #line - 1
    
    XCTAssertTrue(sut.logHandler is MockLogHandler)
    XCTAssertEqual(mockLogHandler.messages.count, 1)
    let resultMessage = try XCTUnwrap(mockLogHandler.messages.first)
    let timestamp = Self.dateFormatter.string(from: Date())
    XCTAssertEqual(resultMessage, "[\(timestamp)] ℹ️ INFO: LoggerTests.swift:\(expectedLine): testInfoMessage():\nEXAMPLE_TITLE:\nEXAMPLE_MESSAGE\n")
  }
  
  func testWarningMessage() throws {
    let mockLogHandler = MockLogHandler()

    let sut = Logger(with: MockLoggerConfiguration(with: .custom(receiver: mockLogHandler)))
    sut.warning(title: "EXAMPLE_TITLE", message: "EXAMPLE_MESSAGE")
    let expectedLine = #line - 1

    XCTAssertTrue(sut.logHandler is MockLogHandler)
    XCTAssertEqual(mockLogHandler.messages.count, 1)
    let resultMessage = try XCTUnwrap(mockLogHandler.messages.first)
    let timestamp = Self.dateFormatter.string(from: Date())
    XCTAssertEqual(resultMessage, "[\(timestamp)] ⚠️ WARNING: LoggerTests.swift:\(expectedLine): testWarningMessage():\nEXAMPLE_TITLE:\nEXAMPLE_MESSAGE\n")
  }
  
  func testErrorMessage() throws {
    let mockLogHandler = MockLogHandler()

    let sut = Logger(with: MockLoggerConfiguration(with: .custom(receiver: mockLogHandler)))
    sut.error(title: "EXAMPLE_TITLE", message: "EXAMPLE_MESSAGE")
    let expectedLine = #line - 1

    XCTAssertTrue(sut.logHandler is MockLogHandler)
    XCTAssertEqual(mockLogHandler.messages.count, 1)
    let resultMessage = try XCTUnwrap(mockLogHandler.messages.first)
    let timestamp = Self.dateFormatter.string(from: Date())
    XCTAssertEqual(resultMessage, "[\(timestamp)] ⛔️ ERROR: LoggerTests.swift:\(expectedLine): testErrorMessage():\nEXAMPLE_TITLE:\nEXAMPLE_MESSAGE\n")
  }
  
  func testTruncatingMessage() throws {
    let mockLogHandler = MockLogHandler()

    let sut = Logger(with: MockLoggerConfiguration(with: .custom(receiver: mockLogHandler), maxMessagesLength: 10))
    sut.error(title: "EXAMPLE_TITLE", message: "EXAMPLE_MESSAGE")
    
    let resultMessage = try XCTUnwrap(mockLogHandler.messages.first)
    let timestamp = Self.dateFormatter.string(from: Date())
    let expectedString = String("[\(timestamp)] ⛔️ ERROR: LoggerTests.swift:147: testErrorMessage():\nEXAMPLE_TITLE:\nEXAMPLE_MESSAGE\n".prefix(10))
      .appending("...")

    XCTAssertEqual(resultMessage, expectedString)
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
    
    var maxMessagesLength: UInt
    
    let timestampFormatter: DateFormatter = dateFormatter
    
    init(with destination: Logger.Log.Destination = .console, maxMessagesLength: UInt = 1000) {
      self.destination = destination
      self.maxMessagesLength = maxMessagesLength
    }
  }
}
