//
//  MGELogger
// 

import Foundation

public extension Logger {
  /// Returns the default configuration for the `Logger`.
  static var defaultConfiguration: LoggerConfiguration {
    DefaultConfiguration()
  }
}

/// Provides the default configuration for the `Logger`.
private struct DefaultConfiguration: LoggerConfiguration {
  let minimumLogLevel: Logger.LogLevel = .info
  
  let maxMessagesLength: UInt = 20_000
  
  let timestampFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = .current
    formatter.timeZone = .current
    formatter.dateFormat = "yy-MM-dd hh:mm:ssSSS"

    return formatter
  }()
}
