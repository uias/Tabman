# Contributing to Tabman

Thanks for your interest in contributing to Tabman! Please have a read through this document for how you can help! 🎉

You can help us reach that goal by contributing. Here are some ways you can contribute:

- [Report any issues or bugs that you find](https://github.com/uias/Tabman/issues/new)
- [Open issues for any new features you'd like Tabman to have](https://github.com/uias/Pageboy/issues/new)
- [Implement other tasks selected for development](https://github.com/uias/Tabman/issues?q=is%3Aissue+is%3Aopen+label%3A%22ready+for+development%22)
- [Help answer questions asked by the community](https://github.com/uias/Tabman/issues?q=is%3Aopen+is%3Aissue+label%3Aquestion)
- [Spread the word about Tabman](https://twitter.com/intent/tweet?text=Tabman,%20a%20powerful%20paging%20view%20controller%20with%20indicator%20bar,%20for%20iOS:%20https://github.com/uias/Tabman)

## Code of conduct

All contributors are expected to follow our [Code of conduct](CODE_OF_CONDUCT.md).
Please read it before making any contributions.

## Setting up the project for development

Tabman relies on a couple of dependencies, `Pageboy` and `PureLayout`. To integrate these dependencies correctly for developing for Tabman you need to do the following:

- Ensure you have [Carthage](https://github.com/Carthage/Carthage) installed. If not, install via Homebrew with `brew install carthage`. 
- Fork / Clone the `Tabman` repository. 
- Run `carthage bootstrap --platform ios`.
- Open `Tabman.xcworkspace` in Xcode and off you go!

The `Tabman-Example` project is useful for manually testing `Tabman`, featuring positional debugging labels and visual cues for ensuring everything is running smoothly. It also provides a good platform for testing dynamically updating the appearance and style responsiveness of any updates. 😁

## Testing

### Running tests

Tests should be added for all functionality, both when adding new behaviors to existing features, and implementing new ones.

Pageboy uses `XCTest` to run its tests, which can either be run through Xcode or by running `$ swift test` in the repository.

## Questions or discussions

If you have a question about the inner workings of Tabman, or if you want to discuss a new feature - feel free to [open an issue](https://github.com/uias/Tabman/issues/new).

Happy contributing! 👨🏻‍💻
