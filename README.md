<p align="center">
    <img src="Artwork/logo.png" width="890" alt="Tabman"/>
</p>

[![Build Status](https://travis-ci.org/uias/Tabman.svg?branch=master)](https://travis-ci.org/uias/Tabman)
[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods](https://img.shields.io/cocoapods/v/Tabman.svg)]()
[![codecov](https://codecov.io/gh/uias/Tabman/branch/master/graph/badge.svg)](https://codecov.io/gh/uias/Tabman)
[![GitHub release](https://img.shields.io/github/release/uias/Tabman.svg)](https://github.com/uias/Tabman/releases)

**Tabman** is a powerful paging view controller with indicator bar, for iOS.

<p align="center">
    <img src="Artwork/header.png" width="890" alt="Tabman"/>
</p>

## Features
- [x] Super easy to implement page view controller with indicator bar.
- [x] Multiple indicator bar styles.
- [x] Simplistic, yet highly extensive customisation.
- [x] Full support for custom components.
- [x] Built on a powerful and informative page view controller, [Pageboy](https://github.com/uias/pageboy).

## Installation
### CocoaPods
Tabman is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'Tabman'
```

And run `pod install`.

### Carthage
Tabman is also available through [Carthage](https://github.com/Carthage/Carthage). Simply install carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

Add Tabman to your `Cartfile`:

```ogdl
github "uias/Tabman" 
```

**Dependencies**

- [Pageboy](https://www.github.com/msaps/Pageboy) by Merrick Sapsford
- [PureLayout](https://www.github.com/PureLayout/PureLayout) by PureLayout

### Example
A nice pretty example project is available to take a look at some of the features that `Tabman` offers. To run the example, simply clone the repo, run 

```ogdl
carthage bootstrap --platform ios
```

and build the workspace.

## Requirements
Tabman requires iOS 9.0 or above.

## Usage
### Getting Started

1) Create an instance of `TabmanViewController` and provide it with a `PageboyViewControllerDataSource`. Note: `TabmanViewController` conforms to and is set as the `PageboyViewControllerDelegate`.

```swift
class YourTabViewController: TabmanViewController, PageboyViewControllerDataSource {

	override func viewDidLoad() {
		super.viewDidLoad()

		self.dataSource = self
	}
}
```

2) Implement the `PageboyViewControllerDataSource` and configure the bar for display.

```swift
func viewControllers(forPageboyViewController pageboyViewController: PageboyViewController) -> [UIViewController]? {
    // return array of view controllers
    let viewControllers = [viewController1, viewController2]

    // configure the bar
    self.bar.items = [TabmanBarItem(title: "Page 1"),
                      TabmanBarItem(title: "Page 2")]

    return viewControllers
}

func defaultPageIndex(forPageboyViewController pageboyViewController: PageboyViewController) -> PageboyViewController.PageIndex? {
    // use default index
    return nil
}
```

3) All done! 🎉

### Going forward
As Tabman is based on [Pageboy](github.com/uias/Pageboy), everything behaves the same and all the same properties/functions are available. Such as these functions for navigation & reloading:

```swift
// Scroll the page view controller to a new page.
public func scrollToPage(_ pageIndex: PageIndex,
                         animated: Bool,
                         completion: PageTransitionCompletion? = nil)

// Reload the view controllers in the page view controller.                         
public func reloadPages()
```

Read up on the `Pageboy` docs to find out a bit more [here](https://www.github.com/uias/Pageboy/blob/master/README.md).

## Child Content Insetting
Tabman will automatically inset any `UITableView` or `UICollectionView`'s that are in the child view controllers provided to the `PageboyViewControllerDataSource`. This behaviour can easily be disabled:

```swift
tabmanViewController.automaticallyAdjustsChildScrollViewInsets = false
```

A `requiredInsets` property is also available on `TabmanBarConfig` which provides any insets required to inset content correctly for the visible `TabmanBar` manually.

## Customisation
The `TabmanBar` in Tabman can be completely customised to your liking, by simply modifying the available properties in the `.bar` `TabmanBarConfig` object.

#### Style
The style of bar to display, by default this is set to `.scrollingButtonBar`.  

##### Available Styles:
<p align="center">
    <img src="Artwork/styles.png" width="890" alt="Pageboy"/>
</p>

For examples on implementing real-world bar styles with `Tabman`, check out [Tabman-Styles](https://github.com/uias/Tabman-Styles).

#### Location
Where you want the bar to appear, either at the top or bottom of the screen. By default this is set to `.preferred` which will use the predefined preferred location for the active style.

The bar will automatically take `UIKit` components such as `UINavigationBar` and `UITabBar` into account.

#### Appearance
The `TabmanBar.Appearance` object provides all the available properties for appearance customisation of a `TabmanBar`. Not all of the properties are appropriate for each style `TabmanBar`, therefore the bar will only respond to the properties it adheres to.

To set a custom appearance definition do the following on a `TabmanViewController`:

```swift
tabViewController.bar.appearance = TabmanBar.Appearance({ (appearance) in
	// customise appearance here
	appearance.text.color = UIColor.red
	appearance.indicator.isProgressive = true
})
```

**Documentation for all the available appearance properties can be found here: [Appearance](Docs/APPEARANCE.md).**

### Advanced

For more advanced customisation, including defining your own indicator and bar styles please read [here](Docs/ADVANCED_CUSTOMISATION.md).

## Getting In Touch
Please feel free to contact me on [Twitter](https://twitter.com/MerrickSapsford).

## Contributing
Bug reports and pull requests are welcome on GitHub at [https://github.com/uias/Tabman](https://github.com/uias/Tabman).

## License

The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
