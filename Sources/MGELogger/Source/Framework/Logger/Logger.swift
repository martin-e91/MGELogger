//
//  MGELogger
//

import Foundation

/// A logger handling console logging.
public final class Logger {
  
  // MARK: - Stored properties
  
  /// Whether the logger is enabled or not.
  public private(set) var isEnabled: Bool = true

  /// The token appended at the end of a truncated string.
  let truncatingToken: String
  
  /// The max characters length of a log message. Any message longer than this value will be truncated.
  /// Default value is `20_000`.
  let maxMessagesLength: UInt
  
  /// A `DateFormatter` for the timestamp in the log messages.
  /// Default format is `yy-MM-dd hh:mm:ssSSS` and `current` `locale` and `timeZone`.
  let timestampFormatter: DateFormatter
  
  /// The level for messages of this logger.
  /// All the message with a higher level are going to be printed.
  /// Default level is `info`.
  private(set) var minimumLogLevel: LogLevel
  
  // MARK: - Init

  /// Applies the given configuration to the logger.
  /// - Parameter configuration: The new configuration.
  public required init(with configuration: LoggerConfiguration = defaultConfiguration) {
    minimumLogLevel = configuration.minimumLogLevel
    maxMessagesLength = configuration.maxMessagesLength
    timestampFormatter = configuration.timestampFormatter
    truncatingToken = configuration.truncatingToken
  }
  
  // MARK: - Functions
  
  /// Updates the `minimumLogLevel` with the given one.
  /// - Parameter minimumLogLevel: The new log level to be set.
  public func change(minimumLogLevel: LogLevel) {
    self.minimumLogLevel = minimumLogLevel
  }
  
  /// Disables the logging for the logger.
  public func disable() {
    isEnabled = false
  }
  
  /// Enables the logging for the logger.
  public func enable() {
    isEnabled = true
  }

  /// Logs with trace level.
  /// - Parameters:
  ///   - title: title to log.
  ///   - message: message to log.
  public func trace(title: String, message: Message, file: String = #file, line: UInt = #line, function: String = #function) {
    handleLog(
      title: title,
      message: "\(message)",
      context: Context(logLevel: .trace, timestamp: currentTimestamp, filePath: file, line: line, function: function)
    )
  }

  /// Logs with debug level.
  /// - Parameters:
  ///   - title: title to log.
  ///   - message: message to log.
  public func debug(title: String, message: Message, file: String = #file, line: UInt = #line, function: String = #function) {
    handleLog(
      title: title,
      message: "\(message)",
      context: Context(logLevel: .debug, timestamp: currentTimestamp, filePath: file, line: line, function: function)
    )
  }

  /// Logs with info level.
  /// - Parameters:
  ///   - title: title to log.
  ///   - message: message to log.
  public func info(title: String, message: Message, file: String = #file, line: UInt = #line, function: String = #function) {
    handleLog(
      title: title,
      message: "\(message)",
      context: Context(logLevel: .info, timestamp: currentTimestamp, filePath: file, line: line, function: function)
    )
  }

  /// Logs with warning level.
  /// - Parameters:
  ///   - title: title to log.
  ///   - message: message to log.
  public func warning(title: String, message: Message, file: String = #file, line: UInt = #line, function: String = #function) {
    handleLog(
      title: title,
      message: "\(message)",
      context: Context(logLevel: .warning, timestamp: currentTimestamp, filePath: file, line: line, function: function)
    )
  }
  
  /// Logs with error level.
  /// - Parameters:
  ///   - title: title to log.
  ///   - message: message to log.
  public func error(title: String, message: Message, file: String = #file, line: UInt = #line, function: String = #function) {
    handleLog(
      title: title,
      message: "\(message)",
      context: Context(logLevel: .error, timestamp: currentTimestamp, filePath: file, line: line, function: function)
    )
  }
}

// MARK: - Private Helpers

private extension Logger {
  var currentTimestamp: String {
    timestampFormatter.string(from: Date())
  }

  /// Formats and logs the given message.
  func handleLog(title: String, message: String, context: Context) {
    guard isEnabled, context.logLevel >= minimumLogLevel else {
      return
    }
    
    let formattedMessage = format(title: title, message: message, context: context)
    
    #if DEBUG
    print(formattedMessage)
    #endif
  }

  /// Formats the given message.
  /// - Parameter message: message to be formatter.
  /// - Returns: a new formatted message.
  func format(title: String, message: Message, context: Context) -> Message {
    let formattedMessage =
      """
      \(context):
      \(title): \(message)

      """

    return truncated(formattedMessage)
  }

  /// Truncates the given message if needed.
  /// - Parameter string: message to be trunked.
  /// - Returns: a `Message` truncated if longer than `maxMessagesLength`.
  func truncated(_ string: String) -> Message {
    string.count >= maxMessagesLength ? string.prefix(Int(maxMessagesLength)).appending(truncatingToken) : string
  }
}
