<p align="center">
    <img src="Docs/img/tm_logo.png" width="890" alt="Tabman"/>
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
    <img src="Docs/img/tm_header.png" width="890" alt="Tabman"/>
</p>
 
## ⭐️ Features
TODO

## 📋 Requirements
Tabman requires iOS 9; and is written in Swift 4.2.

## 📲 Installation
### CocoaPods
Tabman is available through [CocoaPods](http://cocoapods.org):

```ruby
pod 'Tabman', '~> 2.0'
```

### Carthage
Tabman is also available through [Carthage](https://github.com/Carthage/Carthage):

```ogdl
github "uias/Tabman" ~> 2.0
```

## 🚀 Usage

### The Basics
1) Set up your view controller with the an array of view controllers that you want to appear.
2) Set the `PageboyViewControllerDataSource` data source of the `TabmanViewController`.
3) Create, customize and add as many `TMBar`s as you want.

```swift
import Tabman
import Pageboy

class TabViewController: TabmanViewController {

    private var viewControllers = [UIViewController(), UIViewController()]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self

        // Create bar
        let bar = TMBar.ButtonBar()
        bar.animationStyle = .snap // Customize

        // Add to view
        addBar(bar, dataSource: self, at: .top)
    }
}
```

4) Configure your data sources.

```swift
extension TabViewController: PageboyViewControllerDataSource, BarDataSource {

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

    func barItem(for tabViewController: TabmanViewController, at index: Int) -> BarItem {
        let title = "Page \(index)"
        return BarItem(title: title)
    }
}
```

### Choosing a look
Tabman provides numerous, easy to use styles out of the box:

TODO

### Customize all the things
Bar customization is available via properties on each functional area of the bar. Each bar is made up of 4 distinct areas:

<p align="center">
    <img src="Docs/img/bar_breakdown.png" width="890" alt="Bar Breakdown"/>
</p>

#### TMBarView
`TMBarView` is the root view of every bar, and provides the glue for meshing all the other functional areas together. You can change a few things here, such as background style and animation behaviors.

```swift
bar.background.style = .blur(style: .extraLight)
bar.animationStyle = .snap
```
*This is also the entry point for all other customization.*

**More: [**TMBarView Customization**](./Docs/Customization/TMBarView%20Customization.md)**

#### TMBarLayout
`TMBarLayout` is the foundation of a `TMBarView`, dictating how bar buttons are displayed and laid out. Look here if you want to change things such as button spacing, content insets and other layout'y things.

```swift
bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
```
**More: [**TMBarLayout Customization**](./Docs/Customization/TMBarLayout%20Customization.md)**

#### TMBarButton
`TMBarButton` views are populated in the `TMBarLayout` and correspond to the items provided by the data source. This is the place to change things like fonts, image sizing and highlight colors.

As you will most likely dealing with more than one button, you can modify the whole set at once:

```swift
bar.buttons.customize { (button) in
	button.color = .orange
	button.selectedColor = .red
}
```

*This will be applied to both existing bar buttons and any that are added to the bar afterwards.*

**More: [**TMBarButton Customization**](./Docs/Customization/TMBarButton%20Customization.md)**

#### TMBarIndicator
Lastly is `TMBarIndicator` - which indicates the current page index status for the bar. You can change behavior characteristics here as well as how the indicator looks.

```swift
bar.indicator.overscrollBehavior = .compress
bar.indicator.weight = .heavy
```

**More: [**TMBarIndicator Customization**](./Docs/Customization/TMBarIndicator%20Customization.md)**

## 🎨 Advanced Customization
Tabman provides the complete freedom to mix-and-match the built-in components; also define your own.

`TMBarView` leverages generics to define and serve the three distinct functional areas of the bar. This means...

```swift
// ...that the preset...
let bar = Bar.ButtonBar()

// ...is actually under the hood:
let bar = BarView<HorizontalBarLayout, LabelBarButton, LineBarIndicator>
```
So swapping in another type of layout, button or indicator could not be simpler.

Lets say you wanted to actually use a `DotBarIndicator` rather than the `LineBarIndicator`:

```swift
let bar = BarView<HorizontalBarLayout, LabelBarButton, DotBarIndicator>
```
That's as easy as it is.

### Doing my own thing
As replacing the type of layout, button or indicator is as simple as above, you have the ability to define your own subclasses without too much of a headache.

[**Custom Tabman Components**]()

There are also a example projects that showcase custom layouts and such:
- [**Tinderbar**](https://github.com/uias/Tinderbar) - Tinder iOS app layout built with Tabman.

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
