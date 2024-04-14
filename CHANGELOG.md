# Change Log
All notable changes to this project will be documented in this file.
`Tabman` adheres to [Semantic Versioning](http://semver.org/).

#### 3.x Releases
- `3.2.x` Releases - [3.2.0](#320)
- `3.1.x` Releases - [3.1.0](#310)
- `3.0.x` Releases - [3.0.0](#300) | [3.0.1](#301) | [3.0.2](#302)

#### 2.x Releases
- `2.13.x` Releases - [2.13.0](#2130)
- `2.12.x` Releases - [2.12.0](#2120)
- `2.11.x` Releases - [2.11.0](#2110) | [2.11.1](#2111)
- `2.10.x` Releases - [2.10.0](#2100)
- `2.9.x` Releases - [2.9.0](#290) | [2.9.1](#291)
- `2.8.x` Releases - [2.8.0](#280) | [2.8.1](#281) | [2.8.2](#282)
- `2.7.x` Releases - [2.7.0](#270)
- `2.6.x` Releases - [2.6.0](#260) | [2.6.1](#261) | [2.6.2](#262) | [2.6.3](#263)
- `2.5.x` Releases - [2.5.0](#250)
- `2.4.x` Releases - [2.4.0](#240) | [2.4.1](#241) | [2.4.2](#242) | [2.4.3](#243)
- `2.3.x` Releases - [2.3.0](#230)
- `2.2.x` Releases - [2.2.0](#220) | [2.2.1](#221)
- `2.1.x` Releases - [2.1.0](#210) | [2.1.1](#211) | [2.1.2](#212) | [2.1.3](#213) | [2.1.4](#214)
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
## [3.2.0](https://github.com/uias/Tabman/releases/tag/3.2.0)
Released on 2024-04-14

#### Updated
- Downgraded SPM Swift requirement to Swift 5.7 (Xcode 14).

---
## [3.1.0](https://github.com/uias/Tabman/releases/tag/3.1.0)
Released on 2024-04-06

#### Added
- Support for Xcode 15.
- Support for Privacy Manifests.

#### Updated
- Pageboy now requires iOS 12 or tvOS 12.

---
## [3.0.2](https://github.com/uias/Tabman/releases/tag/3.0.2)
Released on 2023-07-16

#### Fixed
- [#615](https://github.com/uias/Tabman/issues/615) Issue where Tabman components would not respond to `tintColor` changes correctly.
     - by [mlmorgan](https://github.com/mlmorgan)

## [3.0.1](https://github.com/uias/Tabman/releases/tag/3.0.1)
Released on 2022-11-08

#### Fixed
- [#605](https://github.com/uias/Tabman/issues/605) Issue where `TMBarView.backgroundView` would not be visible due to broken layout constraints.

## [3.0.0](https://github.com/uias/Tabman/releases/tag/3.0.0)
Released on 2022-11-02

#### Added
- Support for Xcode 14.

#### Updated
- Tabman now requires iOS 11 or newer.
- `delegate` is now `unavailable` on `TabmanViewController`.

---
## [2.13.0](https://github.com/uias/Tabman/releases/tag/2.13.0)
Released on 2022-08-20

#### Updated
- Pageboy to [3.7.0](https://github.com/uias/Pageboy/releases/tag/3.7.0).

#### Fixed
- [#601](https://github.com/uias/Tabman/pull/601) Issue where `AnimateableLabel` would use the incorrect `textColor` when overriding the `userInterfaceStyle`.
     - by [Gyuni](https://github.com/Gyuni)

---
## [2.12.0](https://github.com/uias/Tabman/releases/tag/2.12.0)
Released on 2022-01-15

#### Added
- [#580](https://github.com/uias/Tabman/pull/580) Support for `selectedImage` to `TMTabItemBarButton` and `TMBarItem`.
     - by [divyeshmakwana96](https://github.com/divyeshmakwana96)

#### Fixed
- [#584](https://github.com/uias/Tabman/pull/584) Buttons incorrectly setting selected state on interactive scroll.
     - by [nikitapankiv](https://github.com/nikitapankiv)

---
## [2.11.1](https://github.com/uias/Tabman/releases/tag/2.11.1)
Released on 2021-03-30

#### Fixed
- [#564](https://github.com/uias/Tabman/issues/564) Incorrect separator width in `TMConstrainedHorizontalBarLayout`.
     - by [stefanomondino](https://github.com/stefanomondino)

## [2.11.0](https://github.com/uias/Tabman/releases/tag/2.11.0)
Released on 2021-03-08

#### Added
- Support for Dynamic Type to `TMLabelBarButton` with `adjustsFontForContentSizeCategory`.
- Support for Dynamic Type to `TMTabItemBarButton` with `adjustsFontForContentSizeCategory`.

---
## [2.10.0](https://github.com/uias/Tabman/releases/tag/2.10.0)
Released on 2021-01-23

#### Updated
- [#553](https://github.com/uias/Tabman/issues/553) `leftAccessoryView` and `rightAccessoryView` are now included in accessibility elements in `TMBarView`.
     - by [e-sung](https://github.com/e-sung)

---
## [2.9.1](https://github.com/uias/Tabman/releases/tag/2.9.1)
Released on 2020-07-20

#### Fixed
- Crash when calling `TMBarButton.allTargets` due to `TMBarButtonInteractionController` not being hashable.
     - by [SuperTango](https://github.com/SuperTango)

## [2.9.0](https://github.com/uias/Tabman/releases/tag/2.9.0)
Released on 2020-05-04

#### Updated
- Dropped support for legacy Swift (4.x) versions.
- Pageboy to [3.6](https://github.com/uias/Pageboy/releases/tag/3.6.0).

---
## [2.8.2](https://github.com/uias/Tabman/releases/tag/2.8.2)
Released on 2020-04-25

#### Fixed
- Layout issues when using Right-to-left languages via `semanticContentAttribute`.

## [2.8.1](https://github.com/uias/Tabman/releases/tag/2.8.1)
Released on 2020-04-21

#### Fixed
- Mixed language errors caused by `Tabman.h` header in Swift PM.
     - by [filiplazov](https://github.com/filiplazov)

---
## [2.8.0](https://github.com/uias/Tabman/releases/tag/2.8.0)
Released on 2020-01-12

#### Added
- `verticalAlignment` to `TMLabelBarButton` to allow for button contents to be vertically aligned.

#### Fixed
- Issue where `TMLabelBarButton` would fail to resize correctly when using custom fonts.

---
## [2.7.0](https://github.com/uias/Tabman/releases/tag/2.7.0)
Released on 2019-12-23

#### Added
- `centerDistributed` to `TMBarLayout.Alignment` to center align all bar buttons.
     - by [wwdc14](https://github.com/wwdc14).

#### Updated
- Removed [AutoInsetter](https://github.com/uias/AutoInsetter) as a dependency.
- Child insetting logic now utilises `additionalSafeAreaInsets` only on iOS 11 and above.

#### Fixed
- [#449](https://github.com/uias/Tabman/issues/449) Infinite loop that could be caused by recursive layout calls.
- [#487](https://github.com/uias/Tabman/pull/487) Issue where child contents could be requested to layout before being added to the view hierarchy.
- [#478](https://github.com/uias/Tabman/issues/478) Issue where bar could fail to inset children when created dynamically for the page view controller.

---
## [2.6.3](https://github.com/uias/Tabman/releases/tag/2.6.3)
Released on 2019-10-06

#### Updated
- Pageboy to [3.5.0](https://github.com/uias/Pageboy/releases/tag/3.5.0).

## [2.6.2](https://github.com/uias/Tabman/releases/tag/2.6.2)
Released on 2019-10-03

#### Fixed
- Center aligned `TMBarLayout` not working for trailing buttons.
     - by [townsendeb](https://github.com/townsendeb).
- Center aligned `TMBarLayout` having an incorrect offset when using a non-zero `contentInset`.

## [2.6.1](https://github.com/uias/Tabman/releases/tag/2.6.1)
Released on 2019-09-11

#### Fixed
- Missing imports that could cause a Swift PM build to fail.

## [2.6.0](https://github.com/uias/Tabman/releases/tag/2.6.0)
Released on 2019-09-11

#### Added
- Support for Swift Package Manager in Xcode 11.
- Support for Dark Mode in iOS 13.
- `contentInset` to `TMBadgeView` allowing for custom badge content insets.

#### Fixed
- Issue where accessing `safeAreaLayoutGuide` could cause a crash on Jailbroken devices.
     - by [nghiaphunguyen](https://github.com/nghiaphunguyen).
- Issue where constraints in `TMTabItemBarButton` would not correctly be applied on iOS 13.
     - by [forceunwrap](https://github.com/forceunwrap).
- Issue where a `TMSystemBar` could fail to correctly extend background edges into system areas.

---
## [2.5.0](https://github.com/uias/Tabman/releases/tag/2.5.0)
Released on 2019-08-03

#### Added
- Support for vertical separators between bar buttons to `TMHorizontalBarLayout` via `showSeparators`.
- `separatorColor` to `TMHorizontalBarLayout`.
- `separatorInset` to `TMHorizontalBarLayout`.
- `separatorWidth` to `TMHorizontalBarLayout`.

---
## [2.4.3](https://github.com/uias/Tabman/releases/tag/2.4.3)
Released on 2019-07-13

#### Updated
- Add support for multiple Swift versions to Podspec.

## [2.4.2](https://github.com/uias/Tabman/releases/tag/2.4.2)
Released on 2019-04-25

#### Fixed
- Incorrect Swift version in podspec, now `4.0`.

## [2.4.1](https://github.com/uias/Tabman/releases/tag/2.4.1)
Released on 2019-04-20

#### Fixed
- Build issues with iOS 9.

## [2.4.0](https://github.com/uias/Tabman/releases/tag/2.4.0)
Released on 2019-04-19

#### Added
- Ability to override automatic inset values via `calculateRequiredInsets()` on `TabmanViewController`.
     - by [WingedDoom](https://github.com/WingedDoom)
- [#404](https://github.com/uias/Tabman/issues/404) `adjustsAlphaOnSelection` to `TMBarButton`.
- [#338](https://github.com/uias/Tabman/issues/338) Ability to hide / show the bar with `TMHidingBar`.
- [#403](https://github.com/uias/Tabman/issues/403) Accessibility support to `TMBarView`.
     - by [iv-mexx](https://github.com/iv-mexx)
- [#403](https://github.com/uias/Tabman/issues/403) Accessibility support to `TMBarItem`.
     - by [iv-mexx](https://github.com/iv-mexx)
- [#403](https://github.com/uias/Tabman/issues/403) Accessibility support to `TMBarButton`.
     - by [iv-mexx](https://github.com/iv-mexx)
- [#321](https://github.com/uias/Tabman/issues/321) `navigationItem(item:)` to `TabmanViewController.BarLocation` with support for embedding a `TMBar` in a `UINavigationBar`.

#### Updated
- Make `TMBarItem` `open`.
- Make `.title` open on `TMBarItem`.
- Make `.image` open on `TMBarItem`.
- Make `.badgeValue` open on `TMBarItem`.
- Make `.items` `open` on `TMBarView`.
- Make `.dataSource` `open` on `TMBarView`.
- Make `.delegate` `open` on `TMBarView`.
- Make `.scrollMode` `open` on `TMBarView`.
- Make `.fadesContentEdges` `open` on `TMBarView`.
- Make `.spacing` `open` on `TMBarView`.
- [#396](https://github.com/uias/Tabman/issues/396) Improved layout adaptability of `TMTabItemBarButton` on iPad and in landscape.
- [#404](https://github.com/uias/Tabman/issues/404) `TMBarButton` no longer performs default fade transition in `update(for selectionState:)`

---
## [2.3.0](https://github.com/uias/Tabman/releases/tag/2.3.0)
Released on 2019-03-31

#### Updated
- Added support for Swift 5.
- Added support for Xcode 10.2.
- Improved Swift 4 compatibility.

---
## [2.2.1](https://github.com/uias/Tabman/releases/tag/2.2.1)
Released on 2019-03-24

#### Updated
- AutoInsetter to 1.6 - with numerous fixes and improvements for view controller insetting.

## [2.2.0](https://github.com/uias/Tabman/releases/tag/2.2.0)
Released on 2019-03-14

#### Added 
- [#363](https://github.com/uias/Tabman/issues/363) `.alignment` property to `TMBarLayout` to adjust content alignment.
- [#378](https://github.com/uias/Tabman/pull/378) `.spacing` property to `TMBarView` to adjust spacing between bar content / accessory views.
- [#373](https://github.com/uias/Tabman/pull/373) `setNeedsUpdate()` to `TMBarItemable` to allow for dynamic item updates. 
- [#387](https://github.com/uias/Tabman/issues/387) Ability to show badges on `TMBarButton` via `.badgeValue` on `TMBarItemable`..
- [#392](https://github.com/uias/Tabman/pull/392) `tabmanParent` to `UIViewController`.
- [#392](https://github.com/uias/Tabman/pull/392) `tabmanBarItems` to `UIViewController`.

#### Updated
- [#378](https://github.com/uias/Tabman/pull/378) Improved bar transitioning behavior when adjusting selected tab.
- [#373](https://github.com/uias/Tabman/pull/373) `.title` is now mutable on `TMBarItemable`.
- [#373](https://github.com/uias/Tabman/pull/373) `.image` is now mutable on `TMBarItemable`.

---

## [2.1.4](https://github.com/uias/Tabman/releases/tag/2.1.4)
Released on 2019-02-23

#### Fixed
- [#383](https://github.com/uias/Tabman/issues/383) Child insetting issues on iOS 10.

## [2.1.3](https://github.com/uias/Tabman/releases/tag/2.1.3)
Released on 2019-01-14

#### Fixed
- [#366](https://github.com/uias/Tabman/issues/366) Incorrect indicator positioning when using a Right-to-Left language.

#### Updated
- [#368](https://github.com/uias/Tabman/pull/368) Improve access controls in `TMBarIndicator` and subclasses.
- [#368](https://github.com/uias/Tabman/pull/368) Improve access controls in `TMBarButton`.
- [#368](https://github.com/uias/Tabman/pull/368) Improve access controls in `TMBarLayout`.

## [2.1.2](https://github.com/uias/Tabman/releases/tag/2.1.2)
Released on 2018-12-29

#### Updated
- Swift version to 4.2 in podspec.
    - by [benbahrenburg](https://github.com/benbahrenburg).

#### Fixed
- Annoying conformance warning in `TMBar` caused by Swift compiler bug.
    - by [benbahrenburg](https://github.com/benbahrenburg).

## [2.1.1](https://github.com/uias/Tabman/releases/tag/2.1.1)
Released on 2018-12-24

#### Updated
- Make `TMHorizontalBarLayout` properties `open`.
- Make `TMConstrainedHorizontalBarLayout` properties `open`.
- Make `TMLabelBarButton`  `open`.
- Make `TMTabItemBarButton` `open`.

#### Fixed
- [#358](https://github.com/uias/Tabman/pull/358) Fix typo of TMBarDataSource in README.
    - by [jxltom](https://github.com/jxltom).

## [2.1.0](https://github.com/uias/Tabman/releases/tag/2.1.0)
Released on 2018-12-19

#### Added
- [#355](https://github.com/uias/Tabman/pull/355) Public initializer to `TMAnimation`.
    - by [netspencer](https://github.com/netspencer).

#### Updated
- [#354](https://github.com/uias/Tabman/pull/354) Remove `UIViewController` conformance to `TMBarItemable`.
- Improved documentation.

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
