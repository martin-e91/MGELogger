//
//  MGELogger
// 

import Foundation

public extension Logger {
  /// The logged event metadata.
  /// - Note: It conforms to `CustomStringConvertible` in order to print it directly.
  struct Context {
    
    // MARK: - Stored Properties

    /// The timestamp of when event logged happened.
    public let timestamp: String
    
    /// The log level for the event.
    public let logLevel: Log.Level

    /// The path of the file in which the event logged happened.
    public let filePath: String

    /// The line of the file at which the event logged happened.
    public let line: UInt
    
    /// The line of the file in which the event logged happened.
    public let function: String
    
    // MARK: - Computed Properties

    /// The name of the file.
    public var fileName: String {
      filePath.components(separatedBy: "/").last ?? "unknown_filename"
    }
    
    // MARK: - Init
    
    /// Creates a new `Context` instance.
    /// - Important: This initializer was declared **only** for allowing the testing of `timestamp`.
    internal init(logLevel: Logger.Log.Level, timestamp: String, filePath: String, line: UInt, function: String) {
      self.timestamp = timestamp
      self.logLevel = logLevel
      self.filePath = filePath
      self.line = line
      self.function = function
    }
  }
}

extension Logger.Context: CustomStringConvertible {
  public var description: String {
    "[\(timestamp)] \(logLevel.token): \(fileName):\(line): \(function)"
  }
}
