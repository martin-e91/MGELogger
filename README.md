# MGELogger

⚠️ Currently in development 👨🏾‍💻

## Example

To run the example project, clone this repo, and open MGELogger.xcworkspace from the iOS Example directory.

## Usage 

Add import statement

```swift
import MGELogger
```

Create a `Logger` instance. Usually i create a global variable for convenient access all around the project. 

```swift
let Log = Logger(minimumLogLevel: .debug)
```

Then you can log your message with any level you need:

```swift
...
Log.debug(title: "Network Response", message: body.prettyPrinted)
...
```

Output: 

```shell
========
[20-11-22 03:48:58867] 🐞 DEBUG: ViewController.swift:21: viewDidLoad():
Network Response

{
  "parameter": "value"
}

========
```



## Requirements

Requires iOS 9.0.

## Installation

Add this to your project using Swift Package Manager. 
In Xcode that is simply: 'File > Swift Packages > Add Package Dependency...' paste this repo link and you're done.

## Contributing 

Feel free to give your contribution or open a <a href="https://github.com/martin-e91/MGELogger/issues/new/choose">new issue</a>! 😄


## Author

Martin Essuman


## License

MGELogger is available under the MIT license. See [the LICENSE file](LICENSE) for more information.
