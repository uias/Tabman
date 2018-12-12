# Change Log
All notable changes to this project will be documented in this file.
`Tabman` adheres to [Semantic Versioning](http://semver.org/).

#### 2.x Releases
- `2.0.x` Releases - [2.0.0](#200)

#### 1.x Releases
- `1.10.x` Releases - [1.10.0](#1100) |  [1.10.1](#1101) | [1.1.0.2](#1102)
- `1.9.x` Releases - [1.9.0](#190) | [1.9.1](#191) | [1.9.2](#192)
- `1.8.x` Releases - [1.8.0](#180) | [1.8.1](#181) | [1.8.2](#182)
- `1.7.x` Releases - [1.7.0](#170)
- `1.6.x` Releases - [1.6.0](#160)
- `1.5.x` Releases - [1.5.0](#150) | [1.5.1](#151) | [1.5.2](#152)
- `1.4.x` Releases - [1.4.0](#140) 
- `1.3.x` Releases - [1.3.0](#130) 
- `1.2.x` Releases - [1.2.0](#120) 
- `1.1.x` Releases - [1.1.0](#110) | [1.1.1](#111) | [1.1.2](#112) | [1.1.3](#113) | [1.1.4](#114)
- `1.0.x` Releases - [1.0.0](#100) | [1.0.1](#101) | [1.0.2](#102) | [1.0.3](#103) | [1.0.4](#104) | [1.0.5](#105) | [1.0.6](#106) | [1.0.7](#107) | [1.0.8](#108)

#### 0.x Releases
- `0.8.x` Releases - [0.8.0](#080) | [0.8.1](#081) | [0.8.2](#082) | [0.8.3](#083)
- `0.7.x` Releases - [0.7.0](#070) | [0.7.1](#071) | [0.7.2](#072) | [0.7.3](#073)
- `0.6.x` Releases - [0.6.0](#060) | [0.6.1](#061) | [0.6.2](#062)
- `0.5.x` Releases - [0.5.0](#050) | [0.5.1](#051) | [0.5.2](#052) | [0.5.3](#053)
- `0.4.x` Releases - [0.4.0](#040) | [0.4.1](#041) | [0.4.2](#042) | [0.4.3](#043) | [0.4.4](#044) | [0.4.5](#045) | [0.4.6](#046) | [0.4.7](#047) | [0.4.8](#048)

---
## [2.0.0](https://github.com/uias/Tabman/releases/tag/2.0.0)
Released on 2018-12-02

Basically, everything has changed.

#### Added
- Redesigned and completely re-engineered bar layout system.
- Support for dynamic page insertion & deletion via Pageboy 3.
- Support for multiple bars, including dynamic addition and removal.
- Simplified, more powerful customization via constrained types.
- Ability to add accessory views to bars.
- Support for `UIKit` components such as `UINavigationItem` to bar items.
- Dramatically simplified creation and integration of custom components.

#### Updated
- Improved animation & transitioning engine.
- All views are now exposed via public API.

#### Fixed
- Numerous issues with automatic insetting of child contents.
- A whole lot of performance fixes.
- Numerous memory problems.

---

## [1.10.2](https://github.com/uias/Tabman/releases/tag/1.10.2)
Released on 2018-10-04

#### Fixed
- Cleaned up some potential memory issues in Bar reloading.
    - by [msaps](https://github.com/msaps).

## [1.10.1](https://github.com/uias/Tabman/releases/tag/1.10.1)
Released on 2018-10-03

#### Fixed
- [#331](https://github.com/uias/Tabman/issues/331) App Store submission issues when integrating via Carthage.
    - by [msaps](https://github.com/msaps).

## [1.10.0](https://github.com/uias/Tabman/releases/tag/1.10.0)
Released on 2018-09-20

#### Updated
- Migrated to use Swift 4.2.

---
## [1.9.2](https://github.com/uias/Tabman/releases/tag/1.9.2)
Released on 2018-08-02

#### Fixed
- [#314](https://github.com/uias/Tabman/issues/314) Scrolling Button Bar does not re-layout on rotation for .fill Item Distribution
    - by [rzulkoski](https://github.com/rzulkoski)

## [1.9.1](https://github.com/uias/Tabman/releases/tag/1.9.1)
Released on 2018-06-20

#### Fixed
- [#296](https://github.com/uias/Tabman/pull/296) Visual bug when scrolling between bar buttons with different font styles.
    - by [rzulkoski](https://github.com/rzulkoski)

## [1.9.0](https://github.com/uias/Tabman/releases/tag/1.9.0)
Released on 2018-06-05

#### Added
- [#291](https://github.com/uias/Tabman/issues/291) Fill Item Distribution for Scrolling Button Bar.
    - by [rzulkoski](https://github.com/rzulkoski)

---
## [1.8.2](https://github.com/uias/Tabman/releases/tag/1.8.2)
Released on 2018-04-18

#### Fixed
- [#276](https://github.com/uias/Tabman/issues/276) Animation issue where whole bar would crossfade during an interactive transition.
    - by [msaps](https://github.com/msaps).

## [1.8.1](https://github.com/uias/Tabman/releases/tag/1.8.1)
Released on 2018-04-12

#### Updated
- Improved animation when interactively transitioning between items with a `selectedFont`.
    - by [msaps](https://github.com/msaps).
- `selectedFont` now defaults to `font` if no custom value is set when used in button bars.
    - by [msaps](https://github.com/msaps).

#### Fixed
- [#273](https://github.com/uias/Tabman/issues/273) ssue where selectedTextFont would incorrectly be used for every item in a button bar when not selected.
    - by [msaps](https://github.com/msaps).

## [1.8.0](https://github.com/uias/Tabman/releases/tag/1.8.0)
Released on 2018-04-06

#### Updated
- Now using Pageboy [2.5](https://github.com/uias/Pageboy/releases/tag/2.5.0) with fixes to scroll detection and reliability.
    - by [msaps](https://github.com/msaps). 

---

## [1.7.0](https://github.com/uias/Tabman/releases/tag/1.7.0)
Released on 2018-04-02

#### Added
- `.bottomSeparator` configuration to `TabmanBar.Appearance`.
    - by [msaps](https://github.com/msaps).
- Ability to customize separator height via `Appearance.bottomSeparator.height`.
    - by [leah](https://github.com/leah) & [msaps](https://github.com/msaps).
- Ability to specifiy a selected font for bar items via `Appearance.text.selectedFont`.
    - by [moaible](https://github.com/moaible) & [leah](https://github.com/leah).

#### Updated
- Deprecated `Appearance.State.shouldHideWhenSingleItem`.
    - by [msaps](https://github.com/msaps).
- Deprecated `Appearance.Style.bottomSeparatorColor`.
    - by [msaps](https://github.com/msaps).
- Deprecated `Appearance.Layout.bottomSeparatorEdgeInsets`.
    - by [msaps](https://github.com/msaps).

---

## [1.6.0](https://github.com/uias/Tabman/releases/tag/1.6.0)
Released on 2018-02-23

#### Updated
- Now using Pageboy [2.4](https://github.com/uias/Pageboy/releases/tag/2.4.0) with improved transitioning support.
    - by [msaps](https://github.com/msaps).

---

## [1.5.2](https://github.com/uias/Tabman/releases/tag/1.5.2)
Released on 2018-02-09

#### Updated
- Improved compatiblity with Carthage.
    - Carthage now builds 'Tabman' scheme and target.
    - by [msaps](https://github.com/msaps).

## [1.5.1](https://github.com/uias/Tabman/releases/tag/1.5.1)
Released on 2018-02-05

#### Updated
- Updated AutoInsetter to 1.2 for 'extension safe API' compatibility.
    - by [msaps](https://github.com/msaps).

## [1.5.0](https://github.com/uias/Tabman/releases/tag/1.5.0)
Released on 2018-01-30

#### Updated
- Tabman now uses [AutoInsetter](https://github.com/uias/AutoInsetter).
    - by [msaps](https://github.com/msaps).
- Auto Insetting now takes account of relative subview positioning. 
    - by [msaps](https://github.com/msaps).

#### Fixed
- [#236](https://github.com/uias/Tabman/issues/236) TableView insets not adjusted properly for table with height constraint.
    - by [msaps](https://github.com/msaps).

---

## [1.4.0](https://github.com/uias/Tabman/releases/tag/1.4.0)
Released on 2018-01-13

#### Updated
- [#215](https://github.com/uias/Tabman/pull/215) Add default crossfade transition to custom indicators.
     - by [Limon-O-O](https://github.com/Limon-O-O).
- [#229](https://github.com/uias/Tabman/pull/229) Update project workspace to use CocoaPods for dependency management.
    - by [msaps](https://github.com/msaps).
- [#231](https://github.com/uias/Tabman/pull/231) Update styling for project.
    - by [msaps](https://github.com/msaps).

---

## [1.3.0](https://github.com/uias/Tabman/releases/tag/1.3.0)
Released on 2018-01-10

#### Added 
- [#227](https://github.com/uias/Tabman/pull/227) `parentTabmanBarInsets` property to UIViewController.
     - by [msaps](https://github.com/msaps).

#### Updated
- [#219](https://github.com/uias/Tabman/issues/219) Make Tabman safe to use in extensions.
     - by [msaps](https://github.com/msaps) & [OskarGroth](https://github.com/OskarGroth).
- [#221](https://github.com/uias/Tabman/issues/221) Remove PureLayout dependency.
     - by [msaps](https://github.com/msaps).

---

## [1.2.0](https://github.com/uias/Tabman/releases/tag/1.2.0)
Released on 2017-12-20

#### Added
- [#192](https://github.com/uias/Tabman/issues/192) `automaticallyAdjustsChildViewInsets` to `TabmanViewController`.
     - by [msaps](https://github.com/msaps).

#### Updated
- [#192](https://github.com/uias/Tabman/issues/192) Deprecated `automaticallyAdjustsChildScrollViewInsets`.
     - by [msaps](https://github.com/msaps).
- [#191](https://github.com/uias/Tabman/issues/191) Disable auto-insetting when the bar is embedded or attached.
     - by [msaps](https://github.com/msaps).
- [#208](https://github.com/uias/Tabman/issues/208) Remove temporary fix for iOS 11.2 safe area change.
     - by [msaps](https://github.com/msaps).
     
#### Fixed
- [#190](https://github.com/uias/Tabman/issues/190) Prevent bar background extending when external.
     - by [msaps](https://github.com/msaps).

---

## [1.1.4](https://github.com/uias/Tabman/releases/tag/1.1.4)
Released on 2017-12-20

#### Updated
- Versions of Tabman 1.1.x are now tied to Pageboy 2.1.x.
     - by [msaps](https://github.com/msaps).

## [1.1.3](https://github.com/uias/Tabman/releases/tag/1.1.3)
Released on 2017-12-12

#### Fixed
- [#208](https://github.com/uias/Tabman/issues/208) Auto-Inset issues on iOS 11.2 with bottom safe area.
     - by [msaps](https://github.com/msaps).

## [1.1.2](https://github.com/uias/Tabman/releases/tag/1.1.2)
Released on 2017-12-05

#### Fixed
- [#202](https://github.com/uias/Tabman/issues/202) TabmanBar item views don’t conform to safe area.
     - by [msaps](https://github.com/msaps).

## [1.1.1](https://github.com/uias/Tabman/releases/tag/1.1.1)
Released on 2017-11-28

#### Fixed
- [#194](https://github.com/uias/Tabman/issues/194) UIScrollView contentOffset reset when going back to Tabman VC.
     - by [msaps](https://github.com/msaps).

## [1.1.0](https://github.com/uias/Tabman/releases/tag/1.1.0)
Released on 2017-11-23

#### Added
- [#187](https://github.com/uias/Tabman/pull/187) Behaviors engine to `TabmanBar`.
     - by [msaps](https://github.com/msaps).
- [#186](https://github.com/uias/Tabman/issues/186) Ability to hide TabmanBar with only one item.
     - by [msaps](https://github.com/msaps).
- [#177](https://github.com/uias/Tabman/issues/177) Improve TabmanBar accessibility.
     - by [msaps](https://github.com/msaps).

#### Updated
- Refactored auto insetting logic to `AutoInsetEngine`.
     - by [msaps](https://github.com/msaps).
- Improved auto insetting reliability.
     - by [msaps](https://github.com/msaps).

---

## [1.0.8](https://github.com/uias/Tabman/releases/tag/1.0.8)
Released on 2017-11-15

#### Added
- [#176](https://github.com/uias/Tabman/issues/176) Support for edge insets to bottom separator view.
     - by [msaps](https://github.com/msaps).

#### Fixed
- Removed unnecessary debugging logging.
     - by [msaps](https://github.com/msaps).

## [1.0.7](https://github.com/uias/Tabman/releases/tag/1.0.7)
Released on 2017-11-15

#### Added
- Support for `additionalSafeAreaInsets` for child view controllers. 
     - by [msaps](https://github.com/msaps).

## [1.0.6](https://github.com/uias/Tabman/releases/tag/1.0.6)
Released on 2017-11-12

#### Updated
- Renamed `safeAreaInsets` to `safeArea` in `TabmanBar.Insets`.
     - by [msaps](https://github.com/msaps).

#### Fixed
- Fixed issue where bar background would not extend correctly when using `.preferred` bar location.
     - by [msaps](https://github.com/msaps).
- Fixed issue where child view controller contents would not get inset correctly on iPhone X.
     - by [msaps](https://github.com/msaps).


## [1.0.5](https://github.com/uias/Tabman/releases/tag/1.0.5)
Released on 2017-10-23

#### Added
- Added support for `UICollectionViewController` and automatic insetting.
     - by [msaps](https://github.com/msaps).

#### Fixed
- [#109](https://github.com/uias/Tabman/issues/109) Fixed automatic insetting behavior when using a `UITableViewController`.
     - by [msaps](https://github.com/msaps).

## [1.0.4](https://github.com/uias/Tabman/releases/tag/1.0.4)
Released on 2017-10-22

#### Added
- New `embedBar(in view: UIView)` function to `TabmanViewController`.
     - by [msaps](https://github.com/msaps).

#### Updated
- Deprecated `embedBar(inView view: UIView)` in `TabmanViewController`.
     - by [msaps](https://github.com/msaps).
- Add improved error handling to bar embedding and attachment operations.
     - by [msaps](https://github.com/msaps).

## [1.0.3](https://github.com/uias/Tabman/releases/tag/1.0.3)
Released on 2017-10-11

#### Added
- [#154](https://github.com/uias/Tabman/issues/154) Support for extending bar background on iPhone X function areas.
     - by [msaps](https://github.com/msaps).
- [#148](https://github.com/uias/Tabman/pull/148) `imageRenderingMode` to `TabmanBar.Appearance.Style`.
     - by [thevest](https://github.com/thevest).

## [1.0.2](https://github.com/uias/Tabman/releases/tag/1.0.2)
Released on 2017-09-28

#### Added
- `safeAreaInsets` to `TabmanBar.Insets`.
     - by [msaps](https://github.com/msaps).

#### Updated
- Deprecated `topLayoutGuide` in `TabmanBar.Insets`.
     - by [msaps](https://github.com/msaps).
- Deprecated `bottomLayoutGuide` in `TabmanBar.Insets`.
     - by [msaps](https://github.com/msaps).

#### Fixed
- [#146](https://github.com/uias/Tabman/issues/146) Incorrect layout with automatic insetting on iOS 11 and iPhone X.
     - by [msaps](https://github.com/msaps).

## [1.0.1](https://github.com/uias/Tabman/releases/tag/1.0.1)
Released on 2017-09-18

#### Added
- `context` property to `TabmanBar.Item`.
     - by [Vortec4800](https://github.com/Vortec4800).

#### Updated
- Updated example project styling and improved iPhone X support.
     - by [msaps](https://github.com/msaps).

## [1.0.0](https://github.com/uias/Tabman/releases/tag/1.0.0)
Released on 2017-09-14

#### Added
- Swift 4 support
    - by [msaps](https://github.com/msaps).
- Support for Xcode 9 and iOS 11.
    - by [msaps](https://github.com/msaps).
- Compatibility for [Pageboy 2](https://github.com/uias/Pageboy/releases/tag/2.0.0).
    - by [msaps](https://github.com/msaps).

---

## [0.8.3](https://github.com/uias/Tabman/releases/tag/0.8.3)
Released on 2017-09-05

#### Added
- [#135](https://github.com/uias/Tabman/issues/135) Ability to extend background edge insets under system components.
     - Added by [msaps](https://github.com/msaps).
- [#138](https://github.com/uias/Tabman/pull/138) `extendBackgroundEdgeInsets` property to `TabmanBar.Appearance`.
     - Added by [msaps](https://github.com/msaps).

## [0.8.2](https://github.com/uias/Tabman/releases/tag/0.8.2)
Released on 2017-08-25

#### Fixed
- [#132](https://github.com/uias/Tabman/issues/132) Crash when using `UITableViewController` with auto-insetting enabled.
     - Fixed by [Patrick-Remy](https://github.com/Patrick-Remy).
- Resolved deprecation warnings when using latest Xcode 9 beta.
     - Fixed by [msaps](https://github.com/msaps).

## [0.8.1](https://github.com/uias/Tabman/releases/tag/0.8.1)
Released on 2017-08-04

#### Fixed
- [#121](https://github.com/uias/Tabman/issues/121) Aligment issues when using a single bar item with `.buttonBar`.
     - Fixed by [msaps](https://github.com/msaps).

## [0.8.0](https://github.com/uias/Tabman/releases/tag/0.8.0)
Released on 2017-07-25

#### Updated
- Update Pageboy dependency to 1.4.x.
     - Updated by [msaps](https://github.com/msaps).

---

## [0.7.3](https://github.com/uias/Tabman/releases/tag/0.7.3)
Released on 2017-07-13

#### Updated
- [#108](https://github.com/uias/Tabman/issues/108) Remove lazy variables to fix Carthage linker errors.
     - Fixed by [msaps](https://github.com/msaps).
- Rename `TabmanBarBackgroundView` to `TabmanBar.BackgroundView`.
- Rename `TabmanSeparator` to `Separator`.
- Rename `TabmanCircularView` to `CircularView`.
- Rename `TabmanChevronView` to `ChevronView`.

#### Fixed
- [#115](https://github.com/uias/Tabman/issues/115) Fix text font not being applied to block tab bar.
     - Fixed by [msaps](https://github.com/msaps).

## [0.7.2](https://github.com/uias/Tabman/releases/tag/0.7.2)
Released on 2017-07-10

#### Fixed
- [#111](https://github.com/uias/Tabman/issues/111) Fix issue with `bottomLayoutGuide` inset when using `UITableViewController`.
     - Fixed by [msaps](https://github.com/msaps).
- [#80](https://github.com/uias/Tabman/issues/80) Fix issue where automatic insetting would incorrectly be re-applied when `hidesBarOnSwipe` was enabled on `UINavigationController`.
     - Fixed by [msaps](https://github.com/msaps).

## [0.7.1](https://github.com/uias/Tabman/releases/tag/0.7.1)
Released on 2017-06-30

#### Added
- [#106](https://github.com/uias/Tabman/pull/106) Make `TabmanBar.Item` compatible with both an image and title.
     - Added by [thevest](https://github.com/thevest).

#### Fixed
- [#109](https://github.com/uias/Tabman/issues/109) Fix issue where UITableViewController would not automatically inset correctly.
     - Fixed by [msaps](https://github.com/msaps).

## [0.7.0](https://github.com/uias/Tabman/releases/tag/0.7.0)
Released on 2017-06-24

#### Added
- [#96](https://github.com/uias/Tabman/issues/96) Added compatibility support for iOS 8.
     - Project deployment target is now `8.0`.
     - Added by [farshadmb](https://github.com/farshadmb) & [msaps](https://github.com/msaps).

---

## [0.6.2](https://github.com/uias/Tabman/releases/tag/0.6.2)
Released on 2017-06-19.

#### Added
- [#77](https://github.com/uias/Tabman/issues/77) Support for Right-To-Left languages.
     - Tabman & Pageboy both now fully support localization for right-to-left language layout.

#### Updated
- Pageboy to `1.2`

#### Fixed
- [#91](https://github.com/uias/Tabman/issues/91) Issue where title labels in `TabmanBar` could appear to be using different font sizes due to incorrect layout compression.

## [0.6.1](https://github.com/uias/Tabman/releases/tag/0.6.1)
Released on 2017-06-18.

#### Added
- `minimumItemWidth` to `Appearance.Layout`.
     - Allows for specification of the minimum width an item in a scrolling `TabmanBar` must be for display.
     - By AlexZd
- `Item` typealias for `TabmanBar.Item` to `TabmanViewController`.

#### Updated
- Pageboy to `1.1.2`.

## [0.6.0](https://github.com/uias/Tabman/releases/tag/0.6.0)
Released on 2017-06-14.

#### Added
- `TabmanBarDelegate` delegate property to `TabmanBar.Config`.
- Ability to dictate whether a bar item should be selected.
     - Available via `bar(shouldSelectItemAt index: Int) -> Bool` in `TabmanBarDelegate`.
     - By Fábio Bernardo.
- Ability to hide `TabmanBar` if only one item is provided.
     - Available via `shouldHideWhenSingleItem` in `TabmanBar.Appearance.State`.
     - By Diogo Brito 

#### Updated
- Refactored `TabmanBarItem` to `TabmanBar.Item`.
- Refactored `TabmanBarConfig` to `TabmanBar.Config`.

#### Fixed
- Fixed issue where `useRoundedCorners` would not work on line indicators.
- Fixed issue where bar would incorrectly layout with superview layout changes. 

---

## [0.5.3](https://github.com/uias/Tabman/releases/tag/0.5.3)
Released on 2017-06-09.

#### Added 
- Added `itemSelected(at index: Int)` function to `TabmanBar`.
     - Informs the `TabmanViewController` that an item in the bar has been selected.
- Added `construct(in contentView: UIView, for items: [TabmanBarItem])` function to `TabmanBarLifecycle`.
- Added `add(indicator: TabmanIndicator, to contentView: UIView)` function to `TabmanBarLifecycle`.

#### Removed
- Removed `constructTabBar(items: [TabmanBarItem])` from `TabmanBarLifecycle`.
- Removed `addIndicatorToBar(indicator: TabmanIndicator)` from `TabmanBarLifecycle`.

## [0.5.2](https://github.com/uias/Tabman/releases/tag/0.5.2)
Released on 2017-06-07.

#### Updated
- Updated `Pageboy` to `v1.1.0`.

## [0.5.1](https://github.com/uias/Tabman/releases/tag/0.5.1)
Released on 2017-05-24.

#### Added
- `itemDistribution` property to `TabmanBar.Appearance.Layout`.
     - Allows for centre aligning items within a bar. [#71](https://github.com/uias/Tabman/issues/71)

#### Updated
- Improvements to documentation. 
- Minor refactoring to `TabmanBar.Appearance`.

## [0.5.0](https://github.com/uias/Tabman/releases/tag/0.5.0)
Released on 2017-05-14.

#### Added
- Added Carthage support [#30](https://github.com/uias/Tabman/issues/30).
- Added automatic child view controller insetting behaviour [#43](https://github.com/uias/Tabman/issues/43). 
     - This will automatically inset any `UIScrollView` content that is present in child view controllers to appear correctly with `TabmanBar`.
     - Enabled by default with the `automaticallyAdjustsChildScrollViewInsets` property on `TabmanViewController`.
- Added `requiredInsets` `TabmanBar.Insets` object to `TabmanBarConfig`.
     - Provides inset values for all components required to manually inset content correctly for a `TabmanBar`.
     - Replaces `requiredContentInset`.

#### Updated
- Added a fresh coat of paint.
- Deprecated `requiredContentInset` on `TabmanBarConfig`.
- Move initialisation logic to `viewDidLoad` from `loadView`.

---

## [0.4.8](https://github.com/uias/Tabman/releases/tag/0.4.8)
Released on 2017-04-20.

#### Updated
- Pod releases are now locked to a specific version of `Pageboy`.

#### Fixed
- Fixed deprecation warning for `PageboyViewController.PageIndex` API update.
- [#58](https://github.com/uias/Tabman/issues/58) Fixed missing delegate function from `PageboyViewControllerDelegate` API update.

## [0.4.7](https://github.com/uias/Tabman/releases/tag/0.4.7)
Released on 2017-04-11.

#### Updated
- Updated dependencies.

#### Fixed
- [#51](https://github.com/uias/Tabman/issues/51) Fixed issue with using custom font on bar styles other than `.scrollingButtonBar`. 

## [0.4.6](https://github.com/uias/Tabman/releases/tag/0.4.6)
Released on 2017-04-06.

#### Updated
- Updated podspec to use latest versions of `Pageboy` which contain numerous fixes.

## [0.4.5](https://github.com/uias/Tabman/releases/tag/0.4.5)
Released on 2017-04-05.

#### Fixed
- [#50](https://github.com/uias/Tabman/issues/50) Fixed memory retain issue with `TabmanBarConfig` `.delegate` property.

## [0.4.4](https://github.com/uias/Tabman/releases/tag/0.4.4)
Released on 2017-04-04.

#### Updated
- New artwork and colours for the repo & example app.

#### Fixed
- Fix issue where `requiredContentInset` property on `TabmanViewController.bar` would consistently have incorrect values. 
   - Partial fix for [#42](https://github.com/uias/Tabman/issues/42) - automatic insetting for child view controllers still under development.

## [0.4.3](https://github.com/uias/Tabman/releases/tag/0.4.3)
Released on 2017-03-30.

#### Added
- Additional tests to improve coverage.

#### Updated
- Updated `interaction.isScrollEnabled` to be `true` by default in `TabmanBar.Appearance`.

#### Fixed
- Fixed issue where internally managed `TabmanBar` could potentially be below other subviews.

## [0.4.2](https://github.com/uias/Tabman/releases/tag/0.4.2)
Released on 2017-03-28.

#### Added
- New `.buttonBar` style, which features a static button bar with equally distributed spacing.

#### Updated
- Refactored old `.buttonBar` style to `.scrollingButtonBar`. This is the new default style. 
- A few of the previously `public` properties on various `TabmanBar` styles are now `internal`. These should always be updated via the `TabmanBar.Appearance` object.

#### Fixed
- Issues where certain appearance properties were not always adhered to correctly.
- Issues with `compresses` / `bounces` properties in `TabmanBar.Appearance`. New behaviour simply takes `bounces` as precedence and ignores `compresses`. 
- A few minor layout issues that would appear when setting custom layout appearance properties. 

## [0.4.1](https://github.com/uias/Tabman/releases/tag/0.4.1)
Released on 2017-03-23.

#### Added
- Bottom separator view to `TabmanBar`.
  - This can be customised via `style.bottomSeparatorColor` in `TabmanBar.Appearance`.
- Compressing indicator transition style.
  - Indicator will compress when over scrolling at the end of page ranges rather than bouncing.
  - Enabled via `indicator.compresses` in `TabmanBar.Appearance`.
- Ability to embed internally managed `TabmanBar` in an external view to `TabmanViewController`.
  - Accessible via `embedBar(inView:)` and `disembedBar()`.

#### Updated
- Renamed `.none` to `.clear` in `TabmanBarBackgroundView.BackgroundStyle`.

## [0.4.0](https://github.com/uias/Tabman/releases/tag/0.4.0)
Released on 2017-03-20.

Initial **Tabman** release - A powerful paging view controller with indicator bar for iOS
