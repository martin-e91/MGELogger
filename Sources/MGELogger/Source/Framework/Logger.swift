//
//  MGELogger
//

import Foundation

/// A logger for console logging.
public final class Logger {

  // MARK: - Stored properties
  
  /// The token appended at the end of a truncated string.
  private static let truncatingToken = "<..>"
  
  // MARK: - Stored Properties

  /// Whether the logger is enabled or not.
  public var isEnabled: Bool = true
  
  /// The level for messages of this logger.
  /// All the message with a higher level are going to be printed.
  /// Default level is `info`.
  public let minimumLogLevel: LogLevel
  
  /// The max characters length of a log message. Any message longer than this value will be truncated.
  /// Default value is `20_000`.
  public let maxMessagesLength: UInt
  
  /// A `DateFormatter` for the timestamp in the log messages.
  public let timestampFormatter: DateFormatter

  // MARK: - Init
  
  public required init(configuration: LoggerConfiguration = Logger.defaultConfiguration) {
    minimumLogLevel = configuration.minimumLogLevel
    maxMessagesLength = configuration.maxMessagesLength
    timestampFormatter = configuration.timestampFormatter
  }
}

// MARK: - Public Helpers

public extension Logger {
  /// Logs with trace level.
  /// - Parameters:
  ///   - title: title to log.
  ///   - message: message to log.
  func trace(
    title: String,
    message: Message,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
  ) {
    log(title: title, message: "\(message)", for: .trace, file: file, line: line, function: function)
  }

  /// Logs with debug level.
  /// - Parameters:
  ///   - title: title to log.
  ///   - message: message to log.
  func debug(
    title: String,
    message: Message,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
  ) {
    log(title: title, message: "\(message)", for: .debug, file: file, line: line, function: function)
  }

  /// Logs with info level.
  /// - Parameters:
  ///   - title: title to log.
  ///   - message: message to log.
  func info(
    title: String,
    message: Message,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
  ) {
    log(title: title, message: "\(message)", for: .info, file: file, line: line, function: function)
  }

  /// Logs with warning level.
  /// - Parameters:
  ///   - title: title to log.
  ///   - message: message to log.
  func warning(
    title: String,
    message: Message,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
  ) {
    log(title: title, message: "\(message)", for: .warning, file: file, line: line, function: function)
  }
  
  /// Logs with error level.
  /// - Parameters:
  ///   - title: title to log.
  ///   - message: message to log.
  func error(
    title: String,
    message: Message,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
  ) {
    log(title: title, message: "\(message)", for: .error, file: file, line: line, function: function)
  }
}

// MARK: - Private Helpers

private extension Logger {
  /// Formats and logs the given message.
  private func log(
    title: String,
    message: String,
    for level: LogLevel,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
  ) {
    guard
      isEnabled,
      level.rawValue >= minimumLogLevel.rawValue
    else {
      return
    }
    
    let formattedMessage = format(title: title, message: message, for: level, file: file, line: line, function: function)
    
    print(formattedMessage)
  }

  /// Formats the given message.
  /// - Parameter message: message to be formatter.
  /// - Returns: a new formatted message.
  private func format(
    title: String,
    message: Message,
    for level: LogLevel,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
  ) -> Message {
    let timestamp = timestampFormatter.string(from: Date())
    let fileName = self.fileName(from: file)

    let formattedMessage =
      """

      ========
      [\(timestamp)] \(level.token): \(fileName):\(line): \(function):
      \(title)

      \(message)

      ========

      """
    
    return truncatedMessage(formattedMessage)
  }
  
  /// Returns the filename from the given file path.
  /// - Parameter filePath: the file path that contains the file name.
  /// - Returns: the filename from the given file path.
  private func fileName(from filePath: String) -> String {
    return filePath.components(separatedBy: "/").last ?? "nil_file_name"
  }
  
  /// Truncates the given message if needed.
  /// - Parameter string: message to be trunked.
  /// - Returns: a `Message` truncated if longer than `maxMessagesLength`.
  private func truncatedMessage(_ string: String) -> Message {
    string.count >= maxMessagesLength ?
      string.prefix(Int(maxMessagesLength)).appending(Logger.truncatingToken) : string
  }
}
