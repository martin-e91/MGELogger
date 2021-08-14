//
//  MGELogger
// 

import Foundation

/// The configuration for the `Logger`.
public protocol LoggerConfiguration {
  /// The minimum `LogLevel` determining which log will be included in the logging destination.
  var minimumLogLevel: Logger.LogLevel { get }
  
  /// The max length of the logging messages.
  var maxMessagesLength: UInt { get }
  
  /// The `DateFormatter` that determines how the timestamp of the message will look like.
  var timestampFormatter: DateFormatter { get }
}
