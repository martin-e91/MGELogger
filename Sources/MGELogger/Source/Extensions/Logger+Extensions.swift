//
//  MGELogger
// 

import Foundation

// MARK: - Public Extensions

public extension Logger {
  /// Provides the default configuration for the logger.
  static var defaultConfiguration: LoggerConfiguration {
    DefaultConfiguration()
  }

  /// Whether the logger is disabled or not.
  var isDisabled: Bool {
    !isEnabled
  }
}

// MARK: - Private Extensions

fileprivate extension Logger {
  /// The default configuration for the `Logger`.
  struct DefaultConfiguration: LoggerConfiguration {
    let destination: Logger.Log.Destination = .console
    
    let minimumLogLevel: Logger.Log.Level = .info
    
    let maxMessagesLength: UInt = 20_000
    
    let timestampFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.locale = .current
      formatter.timeZone = .current
      formatter.dateFormat = "yy-MM-dd hh:mm:ssSSS"
      
      return formatter
    }()
    
    let truncatingToken: String = "<..>"
  }
}
