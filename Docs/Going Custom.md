# Going Custom

Tabman provides the facility to create custom components, allowing for you to make any style of bar possible.

### Contents
- [Overview](#overview)
- [Custom Layout](#custom-layout)
- [Custom Bar Buttons](#custom-bar-buttons)

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
## Custom Layout
If you want to change the way that bar buttons are displayed, where they appear or in general just do something a bit different - creating a custom layout is probably the way to go.

### Basics
Create a subclass of `TMBarLayout`.

```swift
import Tabman

class CustomLayout: TMBarLayout {
}
```

`TMBarLayout` provides the following properties that are there to make your life easier when creating your layout:

- `.view: UIView` - View in which the layout should be constructed. All subviews should be added here.
- `.layoutGuide: UILayoutGuide` - Layout guide which provides anchors for the layout in the context of the bar view. As the layouts are inserted within a scroll view, these guides provide access to the visible width of the layout in the bar. Useful if you want to constrain the width to prevent scrollable content.
- `.contentMode: TMBarLayout.ContentMode` - How the buttons are expected to be constrained in the layout (i.e. whether they can intrinsically size or should fit the available width etc.). This is configurable by the user and the layout should react to this appropriately if needed, however the actual AutoLayout logic is handled by the parent.

### Lifecycle
The following lifecycle events occur in a `TMBarLayout`, and a custom implementation is required to implement **all** of them.

```swift
class CustomLayout: TMBarLayout {

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
