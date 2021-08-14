//
//  MGELogger
//

import Foundation

/// A logger for console logging.
public enum Logger {
  
  // MARK: - Static properties
  
  /// Whether the logger is enabled or not.
  public private(set) static var isEnabled: Bool = true
  
  /// Whether the logger is disabled or not.
  public static var isDisabled: Bool {
    !isEnabled
  }
  
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
    log(title: title, message: "\(message)", for: .trace, file: file, line: line, function: function)
  }

  /// Logs with debug level.
  /// - Parameters:
  ///   - title: title to log.
  ///   - message: message to log.
  public static func debug(
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
  public static func info(
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
  public static func warning(
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
  public static func error(
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
  static func log(
    title: String,
    message: String,
    for level: LogLevel,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
  ) {
    guard Self.isEnabled, level.rawValue >= minimumLogLevel.rawValue else {
      return
    }
    
    let formattedMessage = format(title: title, message: message, for: level, file: file, line: line, function: function)
    
    print(formattedMessage)
  }

  /// Formats the given message.
  /// - Parameter message: message to be formatter.
  /// - Returns: a new formatted message.
  static func format(
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
  static func fileName(from filePath: String) -> String {
    return filePath.components(separatedBy: "/").last ?? "nil_file_name"
  }
  
  /// Truncates the given message if needed.
  /// - Parameter string: message to be trunked.
  /// - Returns: a `Message` truncated if longer than `maxMessagesLength`.
  static func truncatedMessage(_ string: String) -> Message {
    string.count >= maxMessagesLength ?
      string.prefix(Int(maxMessagesLength)).appending(Self.truncatingToken) : string
  }
}
