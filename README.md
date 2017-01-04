# SuperSimpleMapper

[![Version](https://img.shields.io/cocoapods/v/SuperSimpleMapper.svg?style=flat)](http://cocoapods.org/pods/SuperSimpleMapper)
[![License](https://img.shields.io/cocoapods/l/SuperSimpleMapper.svg?style=flat)](http://cocoapods.org/pods/SuperSimpleMapper)
[![Platform](https://img.shields.io/cocoapods/p/SuperSimpleMapper.svg?style=flat)](http://cocoapods.org/pods/SuperSimpleMapper)

## Description
SuperSimpleMapper is just a simple utility to map object of one type to object of another type. Useful if you are using an ORM and feel the need to map to plain objects your ORM objects to prevent complex objects polluting all layers of your app. It also works as json mapper but there's lot's of better solutions for that purpose.
.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
No special requirements

## Installation

SuperSimpleMapper is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SuperSimpleMapper"
```

## Usage
### A simple object
Given this object:

```swift

import Foundation

class CoreDataExample {
    var title:String?
    var text:String?
}
class Example {
    var exampleTitle:String?
    var textContent:String?
}
```

Define a location in your app to put all mappings. You can define as many as you need.
In this case between CoreDataExample and Example object:

```swift

import Foundation

Mapper.createMap { (complexExample: CoreDataExample) -> Example in
    let example = Example()
    example.exampleTitle = complexExample.title
    example.textContent = complexExample.text
    return example
}
```
### ...In your mapping layer
```swift
import Foundation

if let result = Mapper.map(source: ComplextComment()) as Comment? {
	//mission complete!!!
}
```
Take a look at Unit Test classes to figure out other use cases



## Author

FrogRain, info@frograin.com

## License

SuperSimpleMapper is available under the MIT license. See the LICENSE file for more info.
