//
//  MGELogger
// 

import Foundation

/// An handler of log messages.
public protocol LogHandler {
  /// Handles the given message properly.
  /// - Parameter message: The message to be handled.
  func handleLog(_ message: Logger.Message)
}
