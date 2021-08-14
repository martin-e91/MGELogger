//
//  MGELogger
// 

import Foundation

extension Logger {
  /// The default configuration for the logger.
  static var defaultConfiguration: LoggerConfiguration {
    DefaultConfiguration()
  }

  /// The default configuration for the `Logger`.
  private struct DefaultConfiguration: LoggerConfiguration {
    public let minimumLogLevel: Logger.LogLevel = .info
    
    public let maxMessagesLength: UInt = 20_000
    
    public let timestampFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.locale = .current
      formatter.timeZone = .current
      formatter.dateFormat = "yy-MM-dd hh:mm:ssSSS"
      
      return formatter
    }()
  }
}
