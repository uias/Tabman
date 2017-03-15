**Note: Tabman is currently in beta; expect a few headaches and potential API changes until we reach stable.**

<p align="center">
    <img src="Artwork/logo.png" width="890" alt="Tabman"/>
</p>

[![Build Status](https://travis-ci.org/msaps/Tabman.svg?branch=master)](https://travis-ci.org/msaps/Tabman)
[![CocoaPods](https://img.shields.io/cocoapods/v/Tabman.svg)]()
[![codecov](https://codecov.io/gh/msaps/Tabman/branch/master/graph/badge.svg)](https://codecov.io/gh/msaps/Tabman)

**Tabman** is a powerful paging view controller with indicator bar component, for iOS.

<p align="center">
    <img src="Artwork/header.png" width="890" alt="Tabman"/>
</p>

## Features
- [x] Super easy to implement page view controller with indicator bar.
- [x] Multiple indicator bar styles.
- [x] Simplistic, yet highly extensive customisation.
- [x] Full support for custom components.
- [x] Built on a powerful and informative page view controller, [Pageboy](github.com//msaps/pageboy).

## Installation
### CocoaPods
Tabman is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:
```ruby
pod 'Tabman'
```
And run `pod install`.

**Dependencies**

- [Pageboy](https://www.github.com/msaps/Pageboy) by Merrick Sapsford
- [PureLayout](https://www.github.com/PureLayout/PureLayout) by PureLayout

### Example
A nice pretty example project is available to take a look at some of the features that `Tabman` offers. When checking out the repo, ensure you include submodules. Simply build and run the project in Xcode.

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

3) All done! 🍻

### Doing a bit more
As `Tabman` is based on [Pageboy](github.com/msaps/Pageboy), everything behaves the same and all the same properties/functions are available. Such as these functions for navigation & reloading:

```swift
// Scroll the page view controller to a new page.
public func scrollToPage(_ pageIndex: PageIndex,
                         animated: Bool,
                         completion: PageTransitionCompletion? = nil)

// Reload the view controllers in the page view controller.                         
public func reloadPages()
```

Read up on the `Pageboy` docs to find out a bit more [here](https://www.github.com/msaps/Pageboy/blob/master/README.md).

## Customisation
The `TabmanBar` in Tabman can be completely customised to your liking, by simply modifying the available properties in the `.bar` `TabmanBarConfig` object.

#### Style
The style of bar to display, by default this is set to `.buttonBar`.  

##### Available Styles:
<p align="center">
    <img src="Artwork/styles.png" width="890" alt="Pageboy"/>
</p>

##### Upcoming Styles:

- `.segmentedBar` - UISegmentedControl style bar.
- `.tabBar` - UITabBar style bar.

#### Location
Where you want the bar to appear, either at the top or bottom of the screen. By default this is set to `.preferred` which will use the predefined preferred location for the active style.

The bar will automatically take `UIKit` components such as `UINavigationBar` and `UITabBar` into account.

#### Appearance
The `TabmanBarAppearance` object provides all the available properties for appearance customisation of a `TabmanBar`. Not all of the properties are appropriate for each style `TabmanBar`, therefore the bar will only respond to the properties it adheres to.

To set a custom appearance definition do this on a `TabmanViewController`:

```swift
tabViewController.bar.appearance = TabmanBar.AppearanceConfig({ (appearance) in
	// customise appearance here
	appearance.text.color = UIColor.red
	appearance.indicator.isProgressive = true
})
```

The following properties are available:

```swift
/// Indicator configuration
public struct Indicator {
	/// The preferred style to use for the indicator.
	/// This is optionally conformed to by the bar.
	public var preferredStyle: TabmanIndicator.Style?
	/// The color of the bar indicator.
	public var color: UIColor?
	/// The weight (thickness) of the bar indicator if using a line indicator.
	public var lineWeight: TabmanLineIndicator.Weight?
	/// Whether the indicator transiton is progressive.
	public var isProgressive: Bool?
	/// Whether the indicator bounces at the end of page ranges.
	public var bounces: Bool?
	/// Whether to use rounded corners on line indicators.
	public var useRoundedCorners: Bool?
}

/// State configuration.
public struct State {
	/// The color to use for selected items in the bar (text/images etc.).
	public var selectedColor: UIColor?
	/// The text color to use for unselected items in the bar (text/images etc.).
	public var color: UIColor?
}

/// Text configuration
public struct Text {
	/// The font to use for text labels in the bar.
	public var font: UIFont?
}

/// Layout configuration
public struct Layout {
	/// The spacing between items in the bar.
	public var interItemSpacing: CGFloat?
	/// The spacing at the edge of the items in the bar.
	public var edgeInset: CGFloat?
}

/// Bar style configuration.
public struct Style {
  /// The background style for the bar.
  public var background: TabmanBarBackgroundView.BackgroundStyle?
  /// Whether to show a fade on the items at the bounds edge of the bar.
  public var showEdgeFade: Bool?
}

/// Bar interaction configuration
public struct Interaction {
    // Whether scroll is enabled on the scroll view in the bar.
    public var isScrollEnabled: Bool?
}
```

### Advanced

For more advanced customisation, including defining your own indicator and bar styles please read [here](Docs/ADVANCED_CUSTOMISATION.md).

## Getting In Touch
Please feel free to contact me on [Twitter](https://twitter.com/MerrickSapsford).

## Contributing
Bug reports and pull requests are welcome on GitHub at [https://github.com/MerrickSapsford/Tabman](https://github.com/MerrickSapsford/Tabman).

## License

The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
