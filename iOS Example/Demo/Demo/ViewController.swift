//
//  ViewController.swift
//  Demo
//
//  Created by Martino Essuman on 22/11/2020.
//

import UIKit
import MGELogger

class ViewController: UIViewController {
  private struct CustomLoggerConfiguration: LoggerConfiguration {
    let destination: Logger.Log.Destination = .console
    
    var minimumLogLevel: Logger.Log.Level { .trace }

    var maxMessagesLength: UInt { 1000 }
  }

  let logger = Logger()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    logger.trace(title: "Stai fort", message: "This is a trace level log message")
    logger.debug(title: "Tutt appost?!", message: "This is a debug message")
    logger.info(title: "We dottò!", message: "This is an info message")
    logger.warning(title: "UEUE'", message: "This is a warning message")
    logger.error(title: "MANNAGG!", message: "This is an error message")
  }
}

