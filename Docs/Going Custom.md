# Going Custom

Tabman provides the facility to create custom components, allowing for you to make any style of bar possible.

### Contents
- [Overview](#overview)
- [Custom Bar Layout](#custom-bar-layout)
- [Custom Bar Buttons](#custom-bar-buttons)
- [Custom Bar Indicator](#custom-bar-indicator)
- [Next Steps](#next-steps)

## Overview

There are three key areas of a `TMBarView` which can easily be subclassed, mixed and matched and modified:

- Layout (`TMBarLayout`) - Dictates the layout and display of the bar contents.
- Bar Buttons (`TMBarButton`) - Physical buttons that are displayed in the bar.
- Indicator (`TMBarIndicator`) - View that indicates currently displayed position in the bar.

`TMBarView` is generically constrained to these three areas:

```swift
TMBarView<LayoutType: TMBarLayout, BarButtonType: TMBarButton, IndicatorType: TMBarIndicator>
```

Meaning interchanging layouts, button styles and indicators is as easy as changing one of these constraints. The preset `TMBar.ButtonBar` under the hood is:

```swift
TMBarView<TMHorizontalBarLayout, TMLabelBarButton, TMLineBarIndicator>
```
## Custom Bar Layout
If you want to change the way that bar buttons are displayed, where they appear or in general just do something a bit different - creating a custom layout is probably the way to go.

### Basics
Create a subclass of `TMBarLayout`.

```swift
import Tabman

class CustomBarLayout: TMBarLayout {
}
```

`TMBarLayout` provides the following properties that are there to make your life easier when creating your layout:

- `.view: UIView` - View in which the layout should be constructed. All subviews should be added here.
- `.layoutGuide: UILayoutGuide` - Layout guide which provides anchors for the layout in the context of the bar view. As the layouts are inserted within a scroll view, these guides provide access to the visible width of the layout in the bar. Useful if you want to constrain the width to prevent scrollable content.
- `.contentMode: TMBarLayout.ContentMode` - How the buttons are expected to be constrained in the layout (i.e. whether they can intrinsically size or should fit the available width etc.). This is configurable by the user and the layout should react to this appropriately if needed, however the actual AutoLayout logic is handled by the parent.

### Lifecycle
The following lifecycle events occur in a `TMBarLayout`, and a custom implementation is required to implement **all** of them.

```swift
class CustomBarLayout: TMBarLayout {

	override func layout(in view: UIView) {
		// Point at which to construct your custom layout.
		//
		// Adding all views to the `view` parameter.
	}
	
	override func insert(buttons: [TMBarButton], at index: Int) {
		// Insert new buttons into the layout.
		//
		// The `index` refers to the lower insertion index (where to start inserting).
	}
	
	override func remove(buttons: [TMBarButton]) {
		// Remove existing buttons from the layout.
		//
		// Remove any buttons in the `buttons` array from the layout views.
	}
	
	override func focusArea(for position: CGFloat, capacity: Int) -> CGRect {
		// Focus area refers to where the bar should be providing 'focus' for a given position.
		//
		// This will be used directly for positioning the indicator.
	}
}
```
Implementing the above functions should provide the flexibility to create any type of layout, and handle all the required `TMBarView` lifecycle events with ease.

### Examples
- [**TinderBarLayout**](https://github.com/uias/Tinderbar/blob/master/Sources/Tinderbar/Bars/TinderBar/TinderBarLayout.swift) - Layout for the main navigation bar in the Tinder iOS app, emulated in [Tinderbar](https://github.com/uias/Tinderbar).

## Custom Bar Buttons
Bar buttons are the indiviual interactable buttons that appear in the bar, and allow the user to directly manipulate the indicated position.

### Basics
Create a subclass of `TMBarButton`.

```swift
import Tabman

class CustomBarButton: TMBarButton {
}
```

`TMBarButton` inherits from `UIControl`, so all the usual responder events are available. A default `.touchUpInside` handler is added to all bar buttons in a bar view, to allow for them to be selected by the user.

### Lifecycle
The following mandatory lifecycle events occur in a `TMBarButton`, a custom implementation is required to implement **all** of them.

```swift
class CustomBarButton: TMBarButton {
	
	override func layout(in view: UIView) {
		super.layout(in: view)
		// Point at which to construct your custom bar button.
		//
		// Adding all views to the `view` parameter.
	}
	
	override func populate(for item: TMBarItemable) {
		super.populate(for: item)
		// Populate your bar button with the data from a bar item.
		//
		// For example, if you only had an image view in your bar button,
		// set the image views image to `item.image`.
	}
}
```

### State
One of the key responsibilities of a bar button is to display state, whether it is currently selected or unselected; and also to be able to smoothly interpolate between these two states. `TMBarButton.SelectionState` is used to handle this.

```swift
public enum SelectionState {
	case unselected
	case partial(delta: CGFloat)
	case selected
}
```
*A `rawValue` property is also available which provides a `CGFloat` from 0.0 to 1.0 reflecting the state.*

Another lifecycle event is available to handle updating the state:

```swift
override func update(for selectionState: TMBarButton.SelectionState) {
	// Update your colors, transforms etc. to reflect being selected / unselected.
	//
	// This is wrapped in a `UIView` animation closure when animated transitions occur,
	// so all properties should be animateable.
}
```

*If you call `super.update(for: selectionState)` a default state is provided - the bar buttons will transition between alpha of 0.5 and 1.0 depending on the state.*

### Examples
- [**TinderBarButton**](https://github.com/uias/Tinderbar/blob/master/Sources/Tinderbar/Bars/TinderBar/TinderBarButton.swift) - Buttons for the main navigation bar in the Tinder iOS app, emulated in [Tinderbar](https://github.com/uias/Tinderbar).

## Custom Bar Indicator
The bar indicator is a view that simply displays the current position in the bar, and is not expected to provide any interaction.

### Basics
Create a subclass of `TMBarIndicator`.

```swift
import Tabman

class CustomBarIndicator: TMBarIndicator {
}
```

An additional extra that is required for an indicator, is to inform the bar view how it needs to be displayed. For this there is the `DisplayMode` enum.

```swift
public enum DisplayMode {
	case top
	case bottom
	case fill
}
```

The cases in `DisplayMode` result in the following:

- `top`: Indicator goes above the bar contents.
- `bottom`: Indicator goes below the bar contents.
- `fill`: Indicator fills the height of the bar, behind the bar contents.

You **must** return the desired `DisplayMode` for the indicator in the `displayMode` property.

```swift
open override var displayMode: TMBarIndicator.DisplayMode {
	return .bottom
}
```

### Lifecycle

The lifecycle for `TMBarIndicator` is really simple, requiring only layout.

```swift
class CustomBarIndicator: TMBarIndicator {
	override func layout(in view: UIView) {
		super.layout(in: view)
	
		// Create your indicator in `view`.
	}
}
```

## Next Steps
So now you've created your custom layouts / buttons / indicators - how do you use them? Well as mentioned previously, you can really easily mix and match all of them in `TMBarView`.

```swift
let customLayoutBar = TMBarView<CustomBarLayout, TMLabelBarButton, TMBarIndicator.None>
let customButtonBar = TMBarView<TMHorizontalBarLayout, CustomBarButton, TMLineBarIndicator>
let allCustomBar = TMBarView<CustomBarLayout, CustomBarButton, CustomBarIndicator>
```