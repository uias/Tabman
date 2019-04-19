# Adding a Bar

`TabmanViewController` supports adding multiple bars to numerous locations on the view controller. This guide covers the intricacies of adding a bar to any of the available `TabmanViewController.BarLocation` locations:

- [top](#top)
- [bottom](#bottom)
- [navigationItem](#navigationItem)
- [custom](#custom)

## top
The `.top` location describes the area at the top of the view controller, insetted below any system areas such as the Safe Area. 

For example, if your view controller is within a `UINavigationController` which has a visbile `UINavigationBar` the `.top` location would describe the area directly below the navigation bar.

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    let bar = TMBar.ButtonBar()
    addBar(bar, dataSource: self, at: .top)
}
```

#### Extending the background
If you would like to use the `TMBar` as a system bar similar to `UINavigationBar` or `UITabBar` you can use the `TMSystemBar` wrapper.

This will extend the background of the bar to the view edges, and add other extras such as a separator.

```swift
addBar(bar.systemBar(), dataSource: self, at: .top)
```

## bottom
The `.bottom` location describes the area at the bottom of the view controller, insetted above any system areas such as the Safe Area. 

For example, if your view controller is within a `UITabBarController`, the `.bottom` location would describe the area directly above the `UITabBar`.

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    let bar = TMBar.TabBar()
    addBar(bar, dataSource: self, at: .bottom)
}
```

#### Extending the background
If you would like to use the `TMBar` as a system bar similar to `UINavigationBar` or `UITabBar` you can use the `TMSystemBar` wrapper.

This will extend the background of the bar to the view edges, and add other extras such as a separator.

```swift
addBar(bar.systemBar(), dataSource: self, at: .bottom)
```

## navigationItem
Tabman also supports displaying a bar within a `UINavigationItem` as its `titleView`.

Due to lifecycle events, it is recommended that you perform this in `viewWillAppear` rather than `viewDidLoad` and also retain your `TMBar` to improve performance.

```swift
let bar = TMBar.ButtonBar()

override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated: Bool)

    addBar(bar, dataSource: self, at: .navigationItem(item: self.navigationItem))
}
```

## custom
If you want a completely custom location for your bar, this is also fully supported by Tabman. This allows you to be add the bar as a subview to a custom specified container view.

⚠️**Note** - Using a custom view will prevent Tabman from providing automatic insetting support for the bar.

```swift
let customContainer = UIView()

override func viewDidLoad() {
    super.viewDidLoad()

    let bar = TMBar.ButtonBar()
    addBar(bar, dataSource: self, at: .custom(view: customContainer, layout: nil))
}
```

This will automatically add the view as a subview to `customContainer` and constrain all four anchors (`leadingAnchor`, `topAnchor`, `trailingAnchor` and `bottomAnchor`) to be equal to the custom view.

#### Custom Layout Constraints
You might also want control over the constraints that are added to the bar when it's added to the custom view - this is where the `layout` parameter comes in. 

By setting this to `nil` you will get the default constraints that are described above, or you can use the closure to build your custom layout:

```swift
addBar(bar, dataSource: self, at: .custom(view: customContainer, layout: { (bar) in
    bar.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        bar.topAnchor.constraint(equalTo: self.customContainer.topAnchor),
        bar.centerXAnchor.constraint(equalTo: self.customContainer.centerXAnchor)
        ])
    }))
```