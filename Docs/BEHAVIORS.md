# Behaviors

The following values can be used to customize the behavior of a `TabmanBar` via the `.bar.behaviors` property on a `TabmanViewController`.

## Available Values

### .autoHide
Adjust whether the bar should hide itself when certain conditions occur.

##### Usage
```swift
.autoHide(.never)
```

##### Options
- `.never` - Always show the bar.
- `.withOneItem` - Hide the bar when only one item is present.
- `.always` - Always hide the bar.
