//
//  MGELogger
// 

import Foundation

public extension Logger {
  /// Provides the default configuration for the `Logger`.
  struct DefaultConfiguration: LoggerConfiguration {
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
}
