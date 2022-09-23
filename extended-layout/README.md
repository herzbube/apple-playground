# extended-layout

This project contains code that deals with the "extended layout" concept introduced by Apple in iOS 7.

I never got around to really understand what is going on there. Instead I developed a dislike for translucent bars and views that extend behind them, where they have no place to be.

Obviously understanding is better than denial, so here goes...

## Schematic

With the default settings a view controller's view is displayed not only within the visible portion below the navigation bar, it extends upwards behind the navigation bar and even behind the status bar.

The actual view content however "magically" remains in the visible portion below the navigation bar. What is extending upward is only the view's **background** - unless something is misconfigured, in which case the content may slip upwards and be partially obscured.

```
+--Window-----------------------------------+
| +--Status bar---------------------------+ |
| | <extended view behind status bar>     | |
| +---------------------------------------+ |
| +--Navigation bar-----------------------+ |
| | <extended view behind navigation bar> | |
| +---------------------------------------+ |
| +-View content--------------------------+ |
| |                                       | |
| |                                       | |
| |                                       | |
| |                                       | |
| |                                       | |
| |                                       | |
| +---------------------------------------+ |
| +--Tab bar------------------------------+ |
| | <extended view behind tab bar>        | |
| +---------------------------------------+ |
+-------------------------------------------+
```

## Test method

The simplest way how to test how extended layout works is to apply background colors to the views involved, and then to manipulate the properties to see what happens.

This playground project implements just that: A tab bar controller with multiple tabs that demonstrate different view controller setups / view layouts. On all tabs except the last you can tap screen elements (table view cells, buttons) to change the values of various properties that are related to extended layout, to get a live preview of the effects of these properties.

- Tab 1: A navigation controller, then inside a table view controller. This demonstrates both the use of a scroll view and UIKit-provided controllers (`UINavigationController`, `UITableViewController`).
- Tab 2: A custom view controller with one navigation bar. This demonstrates that one can have a custom view controller managing a `UINavigationBar`.
- Tab 3: A custom view controller with **three** navigation bars simulating a single navigation bar. This demonstrates that multiple `UINavigationBar` instances are possible - a scenario I have in my Little Go app.
- Tab 4: A navigation controller, then inside a custom view controller. This demonstrates the use of a non-scrolling view.


The idea was borrowed from [this article](https://medium.com/@wailord/extended-layout-in-ios-pre-ios-11-5eff2debf28). The article does a much better job explaining the properties involved than this README.

## View properties

### translucent

If you set the `translucent` property of a `NavigationBar` instance to `NO` its navigation controller will stop extending the view of its root view controller.
Not tested, but this should work for other bars as well.

See `extendedLayoutIncludesOpaqueBars`.

Notes

- Setting the property to `NO` does not give the bar a background color - it will remain transparent. As soon as the scroll view's content is scrolled, however, the navigation bar assumes a background color that is similar to the scrolled up content that is now behind the navigation bar. I have not figured out, though, what the exact mechanism is.
- Setting a background color to the navigation bar will show that color, even if `translucent` is still set to `YES`. The extended view is covered by this colored navigation bar.

### contentInsetAdjustmentBehavior

The `contentInsetAdjustmentBehavior` property ([UIKit docs](https://developer.apple.com/documentation/uikit/uiscrollviewcontentinsetadjustmentbehavior?language=objc)), which is a `UIScrollView` property, is the "new" post-iOS 11 method for adjusting the scroll view insets. It supersedes the view controller property `automaticallyAdjustsScrollViewInsets` (see there).

## View controller properties

### edgesForExtendedLayout

This property ([UIKit docs](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621515-edgesforextendedlayout?language=objc)) by default has value `UIRectEdgeAll`. You can set this property to `UIRectEdgeNone`, or any other combination that does **not** include `UIRectEdgeTop`, to prevent the view from being extended upwards.

When you do this the navigation bar, status bar and safe area will start to show the background of the view of the next view controller that allows its view to extend upwards.

- This could be the navigation controller's view, although that has no background by default.
- If no other view controller has its view extend upwards the window background will be shown.
- If the window also has no background, then a black background will be shown.

### extendedLayoutIncludesOpaqueBars

This property ([UIKit docs](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621404-extendedlayoutincludesopaquebars?language=objc)) by default has value `NO`. If you set it to `YES` then the layout will keep being extended even if a bar's `transclucent` property is set to `NO`.

### automaticallyAdjustsScrollViewInsets

The `automaticallyAdjustsScrollViewInsets` property ([UIKit docs](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621372-automaticallyadjustsscrollviewin?language=objc)) is a view controller property that was deprecated in iOS 11, but at the time of writing is still around.

See `contentInsetAdjustmentBehavior`.

If a view controller's view is a scroll view, the property tells the view controller to adjust the **insets** of the scroll view, so that the content is shifted downwards.

## UIBarPosition

The delegate of a `UINavigationBar` can decide where the navigation bar is positioned. The delegate must adopt the `UINavigationBarDelegate` protocol (which is an extension of the `UIBarPositioningDelegate` protocol) and override the `positionForBar:` method.

The two interesting values are `UIBarPositionTop` and `UIBarPositionTopAttached` - the latter indicates that the navigation bar should extend behind the status bar.
