# MGELogger

A lightweight and easy to use logging module.

## Example

To run the example project, clone this repo, and open MGELogger.xcworkspace from the iOS Example directory.

## Usage 

Add the `import` statement

```swift
import MGELogger
```

Create a  `Logger` instance. You may create a global variable for convenient access all around the project. 

```swift
let logger = Logger()
```

Then you can log your message with any level you need:

```swift
...
logger.debug(title: "Network Response", message: body.prettyPrinted)
...
```

Output: 

```shell
[21-08-14 06:50:38601] 🐞 DEBUG: NetworkProvider.swift:71: decodeBody():
Network Response: 
{
  "address": {
    "city": "Naples",
    "coordinates": {
      "latitude": 40.0,
      "longitude": 45.0
    },
    "country": "IT",
    "province": "NA",
    "street": "Via Toledo, 15"
   }
}
```



## Requirements

Requires iOS 9.0 or above.

## Installation

Add this to your project using Swift Package Manager. 
In Xcode that is simply: 'File > Swift Packages > Add Package Dependency...' paste this repo link and you're all set 👌🏾.

## Contributing 

Feel free to give your contribution or open a <a href="https://github.com/martin-e91/MGELogger/issues/new/choose">new issue</a>! 😄


## Author

Martin Essuman (@martin-e91)

## License

MGELogger is available under the MIT license. See [the LICENSE file](LICENSE) for more information.
