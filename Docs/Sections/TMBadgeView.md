`TMBarButton` supports displaying badges via an `TMBadgeView` which is available as `.badge` on every button 

*Note - it is at the discretion of the button to layout the badge, and some types may not support badging*.

### Displaying a Badge

Setting the value of the badge is defined by the item the bar is displaying:
```swift
func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
    return TMBarItem(title: "My Page", badgeValue: "1")
}
```

`TMBarItemable` also supports these values being dynamically updated, so for example to update the badge value for a child view controller:
```swift
class ChildViewController: UIViewController() {

    var badgeCount = 0

    func increaseBadgeCount() {
        badgeCount += 1

        // Update items in every bar for this page.
        tabmanBarItems?.forEach({ $0.badgeValue = "\(badgeCount)" })
    }
}
```

*Unfortunately `UINavigationItem` and `UITabBarItem` don't support this dynamic update behavior.*

### Customization

Customizing the `TMBadgeView` can all be done via `.badge` on `TMBarButton`.
```swift
bar.buttons.customize { (button) in
    button.badge.tintColor = .blue
}
```