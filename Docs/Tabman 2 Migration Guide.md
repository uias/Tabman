# Tabman 2 Migration Guide

This document outlines the various changes required to migrate to Tabman 2 from a previous version of Tabman.

Tabman 2 is the latest major release of Tabman; ™️ A powerful paging view controller with tab bar for iOS. Tabman 2 introduces several API-breaking changes that should be made aware of.

## Requirements
- iOS 9
- Xcode 10
- Swift 4.2

## What's new
TODO

## Changes

### Displaying a bar
Previously, Tabman only supported having a single bar visible in a `TabmanViewController` at one time, this limitation no longer exists. There is also no longer a 'default' bar that will be displayed in the view controller.

*This also means that defining the style and location of the bar occurs at the time of adding it to the view controller.*

**Tabman 1.x:**

```swift
bar.style = .scrollingButtonBar
bar.location = .top
```

**Tabman 2:**

```swift
let bar = TMBar.ButtonBar()
addBar(bar, dataSource: self, at: .top)
```

*You can also remove a bar from the view controller just as easily using `removeBar(bar)`.*

### Populating a bar
Previously bar items were populated via the `bar.items` property. As seen above, when adding a bar to `TabmanViewController` you now have to provide a `TMBarDataSource` data source.

**Tabman 1.x:**

```swift
bar.items = [Item(title: "Page 1"), Item(title: "Page 2")]
```

**Tabman 2:**

```swift
extension ViewController: TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        return TMBarItem(title: "Page \(index)")
    }
}
```

*`TMBarItemable` also supports UIKit objects such as `UINavigationItem` and `UITabBarItem` so you can directly provide them to `TMBarDataSource`.*

### Customizing a bar
The `TabmanBar.Appearance` proxy was previously used to provide generic properties that could be applied to a `TabmanBar` to change its appearance. The issue with this is that they didn't always apply to all styles, layouts and were very brittle. 

Tabman now leverages generics to fix this problem, with properties on `TMBarLayout`, `TMBarButton` and `TMBarIndicator` subclasses providing a more tailored solution.

#### Indicator

| Tabman 1.x | Tabman 2 |
|------------|----------|
| `appearance.indicator.preferredStyle` | Replaced by `TMBarIndicator` type constraint. |
| `appearance.indicator.color` | `TMLineBarIndicator.tintColor`, `TMChevronBarIndicator.tintColor` |
| `appearance.indicator.lineWeight` | `TMLineBarIndicator.weight` |
| `appearance.indicator.isProgressive` | `TMBarIndicator.isProgressive` |
| `appearance.indicator.bounces` | `TMBarIndicator.overscrollBehavior` |
| `appearance.indicator.compresses` | `TMBarIndicator.overscrollBehavior` |
| `appearance.indicator.useRoundedCorners` | `TMLineBarIndicator.cornerStyle` |


#### State

| Tabman 1.x | Tabman 2 |
|------------|----------|
| `appearance.state.selectedColor` | `TMLabelBarButton.selectedTintColor` `TMTabItemBarButton.selectedTintColor` |
| `appearance.state.color` | `TMLabelBarButton.tintColor` `TMTabItemBarButton.tintColor` |
