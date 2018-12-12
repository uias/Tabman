The layout in a `TMBarView` is probably the most crucial part of the puzzle, it defines the overall look and feel of a bar.

`TMBarLayout` is responsible for inserting, removing and positioning `TMBarButton`s in the view hierarchy. It is also tasked with interpreting a raw page position and providing a frame for 'focus' - the frame in which the bar should indicate current page status.

You are expected to use a `TMBarLayout` subclass such as `TMBarHorizontalLayout` or roll with your own for a completely custom look.