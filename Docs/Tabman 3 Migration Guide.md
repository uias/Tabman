# Tabman 3 Migration Guide

This document outlines the various changes required to migrate to Tabman 3 from a previous version of Tabman.

Tabman 3 is the latest major release of Tabman; A powerful paging view controller with tab bar for iOS. Tabman 3 introduces several API-breaking changes that should be made aware of.

## Requirements
- iOS 11
- Xcode 12
- Swift 5

## What's new

TODO

## API Changes

### TMBarView
- `leftAccessoryView` is now `leadingAccessoryView` in `TMBarView`.
- `leftPinnedAccessoryView` is now `leadingPinnedAccessoryView` in `TMBarView`.
- `rightAccessoryView` is now `trailingAccessoryView` in `TMBarView`.
- `rightPinnedAccessoryView` is now `trailingPinnedAccessoryView` in `TMBarView`.

### TMBarLayout
TODO - Area explanation.

- `layout(in view: UIView)` has been replaced by `layout(in view: UIView, area: LayoutArea)`.
- `insert(buttons: [TMBarButton], at index: Int)` has been replaced by `insert(buttons: [TMBarButton], at index: Int, in area: LayoutArea)`.
- `remove(buttons: [TMBarButton])` has been replaced by `remove(buttons: [TMBarButton], from area: LayoutArea)`.

### Other
- `TabmanViewController.delegate` is now `unavailable` and can not be used.
