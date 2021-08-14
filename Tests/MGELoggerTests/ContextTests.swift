//
//  MGELogger
// 

import XCTest

@testable import MGELogger

final class ContextTests: XCTestCase {
  func testContextDescriptionValue() {
    let context = Logger.Context(logLevel: .info, filePath: #file, line: #line, function: #function)

  }
}
