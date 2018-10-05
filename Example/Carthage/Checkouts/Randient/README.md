<p align="center">
    <img src=".artwork/logo.png" width="890" alt="Tabman"/>
</p>

<p align="center">
    <a href="https://travis-ci.org/uias/Randient">
        <img src="https://travis-ci.org/uias/Randient.svg?branch=master" />
    </a>
    <img src="https://img.shields.io/badge/Swift-4-orange.svg?style=flat" />
    <a href="https://cocoapods.org/pods/Randient">
        <img src="https://img.shields.io/cocoapods/v/Randient.svg" alt="CocoaPods" />
    </a>
	<a href="https://cocoapods.org/pods/Randient">
        <img src="https://img.shields.io/cocoapods/p/Randient.svg" alt="Platforms" />
    </a>
	<a href="https://github.com/Carthage/Carthage">
        <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" />
    </a>
	<a href="https://github.com/uias/Randient/releases">
        <img src="https://img.shields.io/github/release/uias/Randient.svg" />
    </a>
</p>

<p align="center">
    <img src=".artwork/randient.gif" width="450" alt="Tabman"/>
</p>

## ⭐️ Features

- [x] Beautiful, automatically generated gradients from [uiGradients](https://uigradients.com) in Swift.
- [x] Smoothly animating, randomizable gradient views.
- [x] Life is like a box of chocolates.

## 📋 Requirements

iOS 9 & Swift 4.

## 📲 Installation

### CocoaPods

To install Randient using CocoaPods, add this line to your `Podfile`:

```ruby
pod 'Randient'
```

### Carthage

To install Randient using Carthage, add this line to your `Cartfile`:

```ruby
github "Randient"
```

## 🚀 Usage

### Gradient Roulette
`RandientView` is a simple view that will display a randomly selected gradient from the [uiGradients](https://uigradients.com) catalog.

```swift
let randientView = RandientView()
randientView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
view.addSubview(randientView)
```

Updating to a new gradient is as simple as...

```swift
randientView.randomize(animated: true)
```

### Those wonderful gradients

An enum of all the gradients from [uiGradients](https://uigradients.com) is generated every time that Randient is built.

These are available as an enum via `UIGradient`.

```swift
let gradient = UIGradient.royalBlue
let colors = gradient.data.colors
```

If you're feeling lucky, a randomized `UIGradient` can also be retrieved.

```swift
let randomGradient = Randient.randomize()
```

#### The raw stuff

Each `UIGradient` has associated `Data` which can be accessed via `.data`.

```swift
struct Data {
    public let name: String
    public let colors: [UIColor]
}
```

`Metadata` is also available, accessible via `.metadata`.

```swift
struct Metadata {
    public let isPredominantlyLight: Bool
}
```

### Gradient View

`RandientView` inherits from `GradientView`, which under the hood uses simply uses a `CAGradientLayer` for rendering gradients.

`GradientView` provides the following:
- `.colors: [UIColor]?` - Colors of the gradient.
- `.locations: [Double]?` - Locations of each gradient stop.
- `.startPoint: CGPoint` - Start point of the gradient (Defaults to `0.5, 0.0`).
- `.endPoint: CGPoint` - End point of the gradient (Defaults to `0.5, 1.0`).

## 👨🏻‍💻 About
- Created by [Merrick Sapsford](https://github.com/msaps) ([@MerrickSapsford](https://twitter.com/MerrickSapsford))
- Heavily inspired by [UIColor-uiGradientsAdditions](https://github.com/kaiinui/UIColor-uiGradientsAdditions) by [kaiinui](https://github.com/kaiinui).

## ❤️ Contributing
Bug reports and pull requests are welcome on GitHub at [https://github.com/uias/Randient](https://github.com/uias/Randient).

## 👮🏻‍♂️ License
The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
