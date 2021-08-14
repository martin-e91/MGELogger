//
//  MGELogger
// 

import Foundation

public extension Logger.Log {
  /// The destination for the log events.
  enum Destination {
    /// The console destination.
    case console
    
    /// The custom log handler.
    case custom(receiver: LogHandler)
  }
}
