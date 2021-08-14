//
//  MGELogger
//

import Foundation

/// A logger handling console logging.
public enum Logger {
  
  // MARK: - Static properties
  
  /// Whether the logger is enabled or not.
  public private(set) static var isEnabled: Bool = true

  /// The token appended at the end of a truncated string.
  public static let truncatingToken = "<..>"
  
  /// The level for messages of this logger.
  /// All the message with a higher level are going to be printed.
  /// Default level is `info`.
  static private(set) var minimumLogLevel: LogLevel = defaultConfiguration.minimumLogLevel
  
  /// The max characters length of a log message. Any message longer than this value will be truncated.
  /// Default value is `20_000`.
  static private(set) var maxMessagesLength: UInt = defaultConfiguration.maxMessagesLength
  
  /// A `DateFormatter` for the timestamp in the log messages.
  /// Default format is `yy-MM-dd hh:mm:ssSSS` and `current` `locale` and `timeZone`.
  static private(set) var timestampFormatter: DateFormatter = defaultConfiguration.timestampFormatter
  
  // MARK: - Functions

  /// Applies the given configuration to the logger.
  /// - Parameter configuration: The new configuration.
  public static func apply(configuration: LoggerConfiguration) {
    minimumLogLevel = configuration.minimumLogLevel
    maxMessagesLength = configuration.maxMessagesLength
    timestampFormatter = configuration.timestampFormatter
  }
  
  /// Reset the logger by applying the `DefaultConfiguration`.
  public static func resetConfiguration() {
    apply(configuration: defaultConfiguration)
  }
  
  /// Reset the logger by applying the `DefaultConfiguration` and enables the logging.
  public static func resetConfigurationAndEnableLogger() {
    resetConfiguration()
    enable()
  }
  
  /// Enables the logging for the logger.
  public static func enable() {
    isEnabled = true
  }
  
  /// Disables the logging for the logger.
  public static func disable() {
    isEnabled = false
  }

  /// Logs with trace level.
  /// - Parameters:
  ///   - title: title to log.
  ///   - message: message to log.
  public static func trace(title: String, message: Message, file: String = #file, line: UInt = #line, function: String = #function) {
    handleLog(title: title, message: "\(message)", context: Context(logLevel: .trace, filePath: file, line: line, function: function))
  }

  /// Logs with debug level.
  /// - Parameters:
  ///   - title: title to log.
  ///   - message: message to log.
  public static func debug(title: String, message: Message, file: String = #file, line: UInt = #line, function: String = #function) {
    handleLog(title: title, message: "\(message)", context: Context(logLevel: .debug, filePath: file, line: line, function: function))
  }

  /// Logs with info level.
  /// - Parameters:
  ///   - title: title to log.
  ///   - message: message to log.
  public static func info(title: String, message: Message, file: String = #file, line: UInt = #line, function: String = #function) {
    handleLog(title: title, message: "\(message)", context: Context(logLevel: .info, filePath: file, line: line, function: function))
  }

  /// Logs with warning level.
  /// - Parameters:
  ///   - title: title to log.
  ///   - message: message to log.
  public static func warning(title: String, message: Message, file: String = #file, line: UInt = #line, function: String = #function) {
    handleLog(title: title, message: "\(message)", context: Context(logLevel: .warning, filePath: file, line: line, function: function))
  }
  
  /// Logs with error level.
  /// - Parameters:
  ///   - title: title to log.
  ///   - message: message to log.
  public static func error(title: String, message: Message, file: String = #file, line: UInt = #line, function: String = #function) {
    handleLog(title: title, message: "\(message)", context: Context(logLevel: .error, filePath: file, line: line, function: function))
  }
}

// MARK: - Private Helpers

private extension Logger {
  /// Formats and logs the given message.
  static func handleLog(title: String, message: String, context: Context) {
    guard Self.isEnabled, context.logLevel >= minimumLogLevel else {
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
  static func format(title: String, message: Message, context: Context) -> Message {
    let formattedMessage =
      """
      \(context):
      \(title): \(message)

      """
    
    return truncate(formattedMessage)
  }
  
  /// Returns the filename from the given file path.
  /// - Parameter filePath: the file path that contains the file name.
  /// - Returns: the filename from the given file path.
  static func fileName(from filePath: String) -> String {
    return filePath.components(separatedBy: "/").last ?? "nil_file_name"
  }
  
  /// Truncates the given message if needed.
  /// - Parameter string: message to be trunked.
  /// - Returns: a `Message` truncated if longer than `maxMessagesLength`.
  static func truncate(_ string: String) -> Message {
    string.count >= maxMessagesLength ?
      string.prefix(Int(maxMessagesLength)).appending(Self.truncatingToken) : string
  }
}
