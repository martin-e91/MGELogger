//
//  MGELogger
// 

import Foundation

public extension Logger {
  /// The logged event metadata.
  /// - Note: It conforms to `CustomStringConvertible` in order to print it directly.
  struct Context {
    /// The timestamp of when event logged happened.
    let timestamp = Date()
    
    /// The log level for the event.
    let logLevel: LogLevel

    /// The path of the file in which the event logged happened.
    let filePath: String

    /// The line of the file at which the event logged happened.
    let line: UInt
    
    /// The line of the file in which the event logged happened.
    let function: String
    
    /// The name of the file.
    var fileName: String {
      filePath.components(separatedBy: "/").last ?? "unknown_filename"
    }
  }
}

extension Logger.Context: CustomStringConvertible {
  public var description: String {
    "[\(timestamp)] \(logLevel.token): \(fileName):\(line): \(function)"
  }
}
