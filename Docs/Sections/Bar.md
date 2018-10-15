The bar is responsible for conveying the current page position of a `TabmanViewController`, and providing the user with the ability to interact with the page view controller indirectly. In Tabman, this comes in the form of `TMBar`, a protocol that is restricted to `UIView` types. `TMBar` instances can be added to a `TabmanViewController` and are then internally managed by the view controller.

The default `TMBar` provided in Tabman is the `TMBarView`, a flexible view which contains the following core components:
- Layout (`TMBarLayout`) - responsible for dictating the layout and display of the bar.
- Buttons (`TMBarButton`) - interactable views that directly map to each bar item.
- Indicator (`TMBarIndicator`) - view that indicates the currently active item.

These components are defined with generic type constraints on `TMBarView`, providing a huge amount of customization and flexibility. In all likelyhood you will not have to create your own `TMBar` but if required it is absolutely possible.