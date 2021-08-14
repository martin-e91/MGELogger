//
//  MGELogger
// 

import Foundation

public extension Logger {
  /// The logged event metadata.
  struct Context {
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
    "\(fileName):\(line): \(function)"
  }
}
