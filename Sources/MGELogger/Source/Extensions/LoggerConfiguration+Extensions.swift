//
//  MGELogger
// 

import Foundation

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
