# boardpositioncollectionviewcell-layout

This project contains code for experimenting with the Auto Layout constraints of a "board position collection view cell".

The "board position collection view cell" is a class derived from `UICollectionViewCell` which is being used in the Little Go project ([deep link to source](https://github.com/herzbube/littlego/blob/develop/src/play/boardposition/BoardPositionCollectionViewCell.h)). The general cell layout is not too difficult to understand, but because 5 of the 7 subviews are not always visible many dynamic Auto Layout constraints are required to create a fluid layout.

This playground project was created to provide a space with fast build/debug turnaround times for times when the cell layout needs to be changed, or when a layout problem needs to be debugged.

## Layout overview

The following schematic shows how the cell looks like, roughly, when all 7 subviews are visible at the same time.

```
/// +-------------------------------------------------------------------------------------+
/// | +-UIImageView-----------+  +-UILabel--------+ +-UILabel---------+ +-UIImageView---+ |
/// | |                       |  | Text           | | Captured stones | | Info icon     | |
/// | | Node symbol image     |  +----------------+ +-----------------+ +---------------+ |
/// | | (vertically centered) |  +-UILabel--------+ +-UIImageView-----+ +-UIImageView---+ |
/// | |                       |  | Detail text    | | Hotspot icon    | | Markup icon   | |
/// | +-----------------------+  +----------------+ +-----------------+ +---------------+ |
/// +-------------------------------------------------------------------------------------+
```

The node symbol image and the text label are always visible, the other 5 subviews are optionally visible.

Head over to the [Little Go](https://github.com/herzbube/littlego) project to learn what a "board position" is and how the data driving the layout looks like.