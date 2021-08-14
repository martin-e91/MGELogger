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

public extension LoggerConfiguration {
  /// Whether or not the configuration is equal to the given one.
  /// - Parameter other: The other configuration to compare to.
  /// - Returns: `true` if both configurations are equal, `false` elsewhere.
  func isEqual(to other: LoggerConfiguration) -> Bool {
    minimumLogLevel == other.minimumLogLevel &&
      maxMessagesLength == other.maxMessagesLength &&
      timestampFormatter.dateFormat == other.timestampFormatter.dateFormat &&
      timestampFormatter.timeZone == other.timestampFormatter.timeZone &&
      timestampFormatter.calendar == other.timestampFormatter.calendar &&
      timestampFormatter.locale == other.timestampFormatter.locale
  }
}
