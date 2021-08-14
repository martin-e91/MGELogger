//
//  MGELogger
// 

import XCTest

@testable import MGELogger

/// Stores all the logs in `messages` while testing.
final class MockLogHandler: LogHandler {
  var messages: [Logger.Message] = []

  func log(_ message: Logger.Message) {
    messages.append(message)
  }
}
