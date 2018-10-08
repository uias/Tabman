# TMBarView Customization

Customizable properties and functions of `TMBarView` and provided subclasses.

## Contents
- [TMBarView](#tmbarview)

## TMBarView

- #### `.leadingAccessoryView: UIView?`
    Accessory View that is visible at the leading end of the bar view. **Defaults to `nil`**.
- #### `.trailingAccessoryView: UIView?`
    Accessory View that is visible at the trailing end of the bar view. **Defaults to `nil`**.
- #### `.backgroundView: TMBarBackgroundView`
    The view that is displayed behind the bar contents. **Default style is set to `.clear`**.
- #### `.animationStyle: AnimationStyle`
    Style of animation to use when animating updates to bar indicated position.

    Options:
    - `.progressive` - Seemlessly transition between each button in progressive steps.
    - `.snap` - Transition between each button by rounding and snapping to each positional bound.

    **Defaults to `.progressive`**.
- #### `.isScrollEnabled: Bool`
    Whether the bar contents should be allowed to be scrolled by the user. **Defaults to `true`**.
- #### `.fadeEdges: Bool`
    Whether to fade the edges of the bar content. **Defaults to `false`**.