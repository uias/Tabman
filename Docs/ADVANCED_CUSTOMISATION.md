# Advanced Customisation

Tabman can be customised to your own liking; including the definition of custom bars and indicators.

## Creating a custom TabmanBar
1) Simply create a bar object that inherits from `TabmanBar`.

```swift
import UIKit
import Tabman
import Pageboy

class MyCustomBar: TabmanBar {
}
```

2) Implement and override the following methods:

```swift
override func indicatorStyle() -> TabmanIndicator.Style {
	// declare indicator style here
	return .line
}

override func constructTabBar(items: [TabmanBarItem]) {
	super.constructTabBar(items: items)
	
	// create your bar here     
}

override func update(forPosition position: CGFloat,
					 direction: PageboyViewController.NavigationDirection,
					 minimumIndex: Int, maximumIndex: Int) {
	super.update(forPosition: position, direction: direction,
				 minimumIndex: minimumIndex, maximumIndex: maximumIndex)
				 
	// update your bar for a positional update here              
}

override func update(forAppearance appearance: TabmanBar.AppearanceConfig) {
	super.update(forAppearance: appearance)
        
	// update the bar appearance here
}
```

The above functions provide all the necessary lifecycle events for keeping a `TabmanBar` correctly configured and up to date with the page view controller it responds to.

`Tabman` uses `intrinsicContentSize` to calculate the required height of the bar, simply override this to manually specify an explicit height.

3) Configure the `TabmanViewController` to use the new custom style.

```swift
override func viewDidLoad() {
	super.viewDidLoad()
	
	self.bar.style = .custom(type: MyCustomBar.self)
}
```

## Creating a custom TabmanIndicator