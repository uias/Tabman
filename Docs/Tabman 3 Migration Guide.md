# Tabman 3 Migration Guide

This document outlines the various changes required to migrate to Tabman 3 from a previous version of Tabman.

Tabman 3 is the latest major release of Tabman; A powerful paging view controller with tab bar for iOS. Tabman 3 introduces several API-breaking changes that should be made aware of.

## Requirements
- iOS 11
- Xcode 12 or newer
- Swift 5

## What's new
- Added support for Xcode 14.
- Updated minimum deployment target to iOS 11.

## API Changes
- `TabmanViewController.delegate` is now `unavailable` and can not be used.
