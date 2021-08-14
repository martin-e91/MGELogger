//
//  MGELogger
// 

import Foundation

/// Handles logs to the standard output.
/// - Important: This works **only** when the `DEBUG` preprocessor flag is `true`.
struct StandardOutputLogHandler: LogHandler {
  func handleLog(_ message: Logger.Message) {
    #if DEBUG
    print(message)
    #endif
  }
}
