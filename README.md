# MGSelector

![Swift 4.2](https://img.shields.io/badge/Swift-4.2-orange.svg)
[![CI Status](https://img.shields.io/travis/lm2343635/MGSelector.svg?style=flat)](https://travis-ci.org/lm2343635/MGSelector)
[![Version](https://img.shields.io/cocoapods/v/MGSelector.svg?style=flat)](https://cocoapods.org/pods/MGSelector)
[![License](https://img.shields.io/cocoapods/l/MGSelector.svg?style=flat)](https://cocoapods.org/pods/MGSelector)
[![Platform](https://img.shields.io/cocoapods/p/MGSelector.svg?style=flat)](https://cocoapods.org/pods/MGSelector)

MGSelector is a customised table selector for iOS.

<div>
<img src="https://github.com/lm2343635/MGSelector/raw/master/screenshoot/light.png" width="300">
<img src="https://github.com/lm2343635/MGSelector/raw/master/screenshoot/dark.png" width="300">
</div>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

MGSelector is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MGSelector', '~> 0.1'
```

## Documentation

Prepare your model which confirms the MGSelectorModel protocol at first.
```Swift
struct Option: MGSelectorOption {
    var title: String
    var detail: String?
}
```
Confirm the MGSelectable protocol in your view controller, and invokes the `openSelector` method.

```Swift
let options: [Options] = ...

class ViewController: UIViewController, MGSelectable {
    //...

    @IBAction func open(_ sender: UIButton) {
        openSelector(title: "Title", options: options, theme: .dark)
    }
    
    func didSelect(option: MGSelectorOption) {
        title = option.title
    }
}
```

Get the select result using the `didSelect` protocol method.

## Author

lm2343635, lm2343635@126.com

## License

MGSelector is available under the MIT license. See the LICENSE file for more info.
