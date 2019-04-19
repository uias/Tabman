`TMHidingBar` allows you to hide/show a `TMBar` manually and automatically with triggers.

It is provided as an extension to a `TMBar`, similar to `TMSystemBar`:
```swift
let bar = TMBar.ButtonBar()
let hidingBar = bar.hiding(trigger: .time(duration: 5))
```

This would create a `TMBar.ButtonBar` that is automatically hidden after 5 seconds.

*Recommendation - you should always use `.hiding()` as the final function when creating a bar.*

**As Tabman relies so heavily on type inference - you should ensure you are using the correct types for customization with the `TMBar` extensions. For example:**

```swift
TMBar.ButtonBar() -> TMBarView<TMHorizontalBarLayout, TMLabelBarButton, TMLineBarIndicator>
TMBar.hiding(trigger:) -> TMHidingBar
```

## Hide and Show

`TMHidingBar` provides show / hide functions that can be called at any time to hide the bar.

```swift
bar.hide(animated: true, completion: nil)
bar.show(animated: true, completion: nil)
```
*.show(animated:completion:) is automatically called when the bar is updated for a page change. You are responsible for calling it in any other desired scenario.*

The transition that is used for animation is dependent on the `transition` property.
```swift
bar.transition = .drawer
bar.transition = .fade
```

### Triggers
`TMHidingBar` provides configurable triggers that are passed as the `trigger:` parameter during initialization. These triggers have the ability to automatically hide and show the bar based on their type. They can of course be overriden by manual show / hide function calls.

#### `.manual`
The manual trigger does nothing, and allows you to show / hide the bar manually with show / hide calls.

```swift
.manual
```

#### .time`
The time trigger will hide the bar after a specified `TimeInterval` has elapsed. 

```swift
.time(duration: 10)
```