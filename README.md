<p align="center">
    <img src="Artwork/logo.png" width="890" alt="Tabman"/>
</p>

<p align="center">
    <a href="https://travis-ci.org/uias/Tabman">
        <img src="https://travis-ci.org/uias/Tabman.svg?branch=master" />
    </a>
    <img src="https://img.shields.io/badge/Swift-4-orange.svg?style=flat" />
    <a href="https://cocoapods.org/pods/Tabman">
        <img src="https://img.shields.io/cocoapods/v/Tabman.svg" alt="CocoaPods" />
    </a>
	<a href="https://cocoapods.org/pods/Tabman">
        <img src="https://img.shields.io/cocoapods/p/Tabman.svg" alt="Platforms" />
    </a>
	<a href="https://github.com/Carthage/Carthage">
        <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" />
    </a>
	<a href="https://codecov.io/gh/uias/Tabman">
        <img src="https://codecov.io/gh/uias/Tabman/branch/master/graph/badge.svg" />
    </a>
	<a href="https://github.com/uias/Tabman/releases">
        <img src="https://img.shields.io/github/release/uias/Tabman.svg" />
    </a>
</p>

<p align="center">
    <img src="Artwork/header.png" width="890" alt="Tabman"/>
</p>
 
## ⭐️ Features
- [x] Super easy to implement page view controller with indicator bar.
- [x] Multiple indicator bar styles.
- [x] Simplistic, yet highly extensive customisation.
- [x] Full support for custom components.
- [x] Built on a powerful and informative page view controller, [Pageboy](https://github.com/uias/pageboy).

## 📋 Requirements
Tabman requires iOS 9, Swift 4 and uses [Pageboy 2](https://github.com/uias/Pageboy/releases/tag/2.0.0).

For details on using older versions of Tabman or Swift please see [Compatibility](Docs/COMPATIBILITY.md).

## 📲 Installation
### CocoaPods
Tabman is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'Tabman', '~> 1.0'
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
github "uias/Tabman" ~> 1.0
```

## 🚀 Usage

### The Basics

1) Create a `TabmanViewController` and provide a `PageboyViewControllerDataSource`, then set the items you want to display in the bar. 

	*Note: `TabmanViewController` conforms to and is set as the `PageboyViewControllerDelegate`.*

```swift
class YourTabViewController: TabmanViewController, PageboyViewControllerDataSource {

	override func viewDidLoad() {
		super.viewDidLoad()

		self.dataSource = self

        	// configure the bar
        	self.bar.items = [Item(title: "Page 1"),
                          	  Item(title: "Page 2")]
	}
}
```

2) Implement `PageboyViewControllerDataSource`.

```swift
func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
    return viewControllers.count
}
    
func viewController(for pageboyViewController: PageboyViewController,
                    at index: PageboyViewController.PageIndex) -> UIViewController? {
    return viewControllers[index]
}
    
func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
    return nil
}
```

3) All done! 🎉

### Page View Controller
As Tabman is based on **[Pageboy](https://github.com/uias/Pageboy)**, all the extras and niceities in a `PageboyViewController` are available in a`TabmanViewController`. Including:

- Simplified data source management.
- Enhanced delegation; featuring exact relative positional data and reliable updates.
- Infinite scrolling support.
- Automatic timer-based page transitioning.
- Support for custom page transitions.

Read up on the **Pageboy** documentation [here](https://github.com/uias/Pageboy#usage).

### Child Content Insetting
Tabman will automatically attempt to inset any `UIScrollView` (including derivatives) that if finds within it's child view controllers. This is enabled by default:

```swift
.automaticallyAdjustsChildScrollViewInsets = true
```
***NOTE**: If you wish to disable this behaviour, you must do so **before** setting the `dataSource` on the `TabmanViewController`.*

*The values used for insetting the child content are also available for manual use at `bar.requiredInsets`, and via `.parentTabmanBarInsets` from child view controllers. Additionally, `additionalSafeAreaInsets` are also configured to allow for content to be pinned to the safe areas under iOS 11.*

**Troubleshooting** - If you are having issues with the automatic insetting behaviour of Tabman, please check out the [Automatic Insetting Troubleshooting Guide](Docs/TROUBLESHOOTING.md#automatic-insetting). If you still are having issues, please raise an [issue](https://github.com/uias/Tabman/issues/new).

## Customization
The bar in Tabman can be completely customized to your liking, by simply modifying the properties in the `.bar` configuration:

#### Style
The style of bar to display, by default this is set to `.scrollingButtonBar`.

```swift
tabViewController.bar.style = .buttonBar
```

##### Available Styles:
<p align="center">
    <img src="Artwork/styles.png" width="890" alt="Pageboy"/>
</p>

*For examples on implementing real-world bar styles with `Tabman`, check out [Tabman-Styles](https://github.com/uias/Tabman-Styles).*

#### Location
Choose where you want the bar to appear, by default this is set to `.preferred` which will use the predefined preferred location for the active style.

```swift
tabViewController.bar.location = .top
```

#### Appearance
Customization of the appearance and styling of a bar is available via `.appearance`. Providing a custom `TabmanBar.Appearance` will instantly update the appearance of the active bar:

```swift
tabViewController.bar.appearance = TabmanBar.Appearance({ (appearance) in

	// customize appearance here
	appearance.state.selectedColor = UIColor.red
	appearance.text.font = .systemFont(ofSize: 16.0)
	appearance.indicator.isProgressive = true
})
```

*The full list of appearance properties can be found [here](Docs/APPEARANCE.md).*

*For more advanced customisation, including defining your own indicator and bar styles please read [here](Docs/ADVANCED_CUSTOMISATION.md).*

#### Behaviors
You can also enable different behaviors via `.behaviors`. Simply provide an array of your desired `TabmanBar.Behavior` values and the bar will start using them:

```swift
tabViewController.bar.behaviors = [.autoHide(.always)]
```

*The full list of available behaviors can be found [here](Docs/BEHAVIORS.md).*

## ⚠️ Troubleshooting
If you are encountering issues with Tabman, please check out the [Troubleshooting Guide](Docs/TROUBLESHOOTING.md).

If you're still having problems, feel free to raise an [issue](https://github.com/uias/Tabman/issues/new).

## 👨🏻‍💻 About
- Created by [Merrick Sapsford](https://github.com/msaps) ([@MerrickSapsford](https://twitter.com/MerrickSapsford))
- Contributed to by a growing [list of others](https://github.com/uias/Tabman/graphs/contributors).


## ❤️ Contributing
Bug reports and pull requests are welcome on GitHub at [https://github.com/uias/Tabman](https://github.com/uias/Tabman).

## 👮🏻‍♂️ License
The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
