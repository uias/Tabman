# Advanced Customisation

Tabman can be customised to your own liking; including the definition of custom bars and indicators.

## Contents
- [Creating a custom TabmanBar](#creating-a-custom-tabmanbar)
- [Using an external TabmanBar](#using-an-external-tabmanbar)
- [Embedding TabmanBar in an external view](#embedding-tabmanbar-in-an-external-view)

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
override func defaultIndicatorStyle() -> TabmanIndicator.Style {
	// declare default indicator style here
	return .line
}

override func usePreferredIndicatorStyle() -> Bool {
	// whether the bar should use preferredIndicatorStyle
	return true
}

override func constructTabBar(items: [TabmanBarItem]) {
	
	// create your bar here     
}

override func addIndicatorToBar(indicator: TabmanIndicator) {
	// add the indicator to the bar here
}

override func update(forPosition position: CGFloat,
                direction: PageboyViewController.NavigationDirection,
                indexRange: Range<Int>,
                bounds: CGRect) {
	super.update(forPosition: position, direction: direction,
				 indexRange: Range<Int>,
				 bounds: CGRect)
				 
	// update your bar contents for a positional update here              
}

override func update(forAppearance appearance: Appearance, 
                     defaultAppearance: Appearance) {
	super.update(forAppearance: appearance,
	             defaultAppearance: defaultAppearance)
        
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

### Using a custom TabmanIndicator
As seen above, when creating a `TabmanBar` subclass you can specify the style for the indicator in `indicatorStyle()`.

```swift
override func indicatorStyle() -> TabmanIndicator.Style {
	return .line
}
```

This can be used to return a custom view to use as the `TabmanIndicator`:

1) Create an object that inherits from `TabmanIndicator`.

```swift
import UIKit
import Tabman
import Pageboy

class MyCustomIndicator: TabmanIndicator {
}
```

2) Implement and override the following methods:

```swift
public override func constructIndicator() {
        super.constructIndicator()
        
        // create your indicator here
}
```

3) Configure your custom `TabmanBar` to use your custom indicator.

```swift
override func indicatorStyle() -> TabmanIndicator.Style {
	return .custom(type: MyCustomIndicator.self)
}
```

## Using an external TabmanBar
`TabmanViewController` supports the ability to use an external `TabmanBar` rather than the internally managed one if required. 

This is available by calling the `attach(bar:)` function as follows: 

```swift
class MyTabmanViewController: TabmanViewController {

	func viewDidLoad() {
		super.viewDidLoad()
		
		let customBar = CustomTabmanBar()
		self.attach(bar: customBar)
	}
}

```
This will hide the internally managed `TabmanBar` and provide updates to the attached bar. 

If required, this bar can also be detached later by calling:

```swift
// detaches and returns the currently attached TabmanBar
func detachAttachedBar() -> TabmanBar?
```

## Embedding TabmanBar in an external view
You can also embed the internally managed `TabmanBar` in an external view. This allows for all the advantages of internal management (Style switching etc.) but in a specified view elsewhere in the view hierarchy.

This is available with the `embedBar(inView:)` function.

```swift
class MyTabmanViewController: TabmanViewController {

	let customBarView = UIView()

	func viewDidLoad() {
		super.viewDidLoad()
		
		self.embedBar(inView: customBarView)
	}
}

```

When called, this will add the `TabmanBar` as a subview within the custom view, and pin it to all four edges (leading, top, trailing, bottom).

You can also disembed the `TabmanBar` from the external view like this:

```swift
func disembedBar()
```

This will restore normal behaviour and embed the bar in its original internal location.
