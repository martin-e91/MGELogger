//
//  MGELogger
// 

import Foundation

public extension Logger.Log {
  /// Log level for the `Logger` used to determinate what to omit from logging output.
  enum Level: Severity {
    /// Messages that contains information only when debugging a program.
    case trace
    
    /// Messages that contain information normally of use only when debugging a program.
    case debug
    
    /// Informational messages.
    case info
    
    /// Messages that require attention.
    case warning
    
    /// Messages for error conditions.
    case error
    
    /// A token string associated with this log level.
    var token: String {
      switch self {
      case .trace:
        return "🤔 TRACE"
        
      case .debug:
        return "🐞 DEBUG"
        
      case .info:
        return "ℹ️ INFO"

      case .warning:
        return "⚠️ WARNING"
        
      case .error:
        return "⛔️ ERROR"
      }
    }
  }
}

// MARK: - Comparable Conformance

extension Logger.Log.Level: Comparable {
  public static func < (lhs: Logger.Log.Level, rhs: Logger.Log.Level) -> Bool {
    lhs.rawValue < rhs.rawValue
  }
}
