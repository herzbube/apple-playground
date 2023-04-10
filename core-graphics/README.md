# core-graphics

This project provides a user interface that lets the user interactively explore Core Graphics drawing functions. As a side effect, this project demonstrates how to build a UI with reusable view controllers that load their views and Auto Layout constraints from .xib files.

Although I believe I have a relatively solid grasp of the basic Core Graphics drawing functions (e.g. drawing paths like circles, rectangles or lines, plus filling and stroking such paths), from time to time I encounter a new thing that I need to wrap my head around. This is especially true when it comes to affine transformations.

The user interface in this project exposes Core Graphics drawing functions and their parameters to the user as raw as possible so that the user can play with them.

**Important note:** Core Graphics drawing contexts have the origin of their coordinate system in the lower-left corner. The documentation of Core Graphics functions reflects this. UiKit drawing contexts, however, have the origin of their coordinate system in the upper-left corner. **This project performs drawing with a UiKit drawing context.** Keep this in mind when comparing Core Graphics function documentations with the drawing results from this project.

## UI workflow

This project does not pretend to be a full-fledged drawing application. It merely has the following very limited workflow:

1. The user selects a path to draw, and the path parameters.
2. The user selects whether to stroke the path, and the stroking parameters (line width, color).
3. The user selects whether to fill the path, and the fill parameters (fill color if solid color fill is selected, or gradient parameters if gradient fill is selected).
4. The user selects whether to use an affine transformation for drawing the path, and the affine transformation parameters.
5. The user selects whether to draw a gradient, and the gradient parameters. Note that the affine transformation from step 4 is not applied to the gradient - the gradient parameters allow to set a gradient-specific affine transform.

## Core Graphics function coverage

The following table lists the Core Graphics functions currently supported by this project. The reference document is [Apple's Core Graphics documentation](https://developer.apple.com/documentation/coregraphics?language=objc).

| Function         | Parameters | Notes |
|------------------|------------|-------|
| CGContextAddArc | <ul><li>center x,y: 2x `CGFloat`</li> <li>radius: `CGFloat`</li> <li>startAngle, endAngle: 2x `CGFloat`</li> <li>clockwise: `boolean` (actually `int`)</li></ul> | Input for start/end angle is in degrees, measured from the positive x-axis. |
| CGContextAddRect | <ul><li>rectangle: `CGRect`</li></ul> | |
| CGContextSetLineWidth | <ul><li>width: `CGFloat`</li></ul> | |
| CGContextSetStrokeColorWithColor | <ul><li>color: `CGColorRef`</li></ul> | |
| CGContextStrokePath | None | This function is used if the path needs to be stroked, but not filled with a solid color. |
| CGContextSetFillColorWithColor | <ul><li>color: `CGColorRef`</li></ul> | |
| CGContextFillPath | None | This function is used if the path needs to be filled with a solid color, but not stroked. |
| CGContextDrawPath | <ul><li>drawingMode: `CGPathDrawingMode`</li></ul> | This function is used if the path needs to be stroked **and** filled with a solid color. The drawing mode parameter value is always `kCGPathFillStroke`. |
| CGContextConcatCTM | <ul><li>transform: `CGAffineTransform`</li></ul> | The `CGAffineTransform` type is a structure that holds the 6 parameters (a, b, c, d, tx, ty) described in the "Affine transformation notes" section below. |
| CGContextRotateCTM | <ul><li>angle: `CGFloat`</li></ul> | Input is in degrees. Positive values rotate clockwise, negative values rotate counterclockwise. The Core Graphics function documentation has it the other way round, the reason is that UiKit drawing contexts use a flipped coordinate system. |
| CGContextScaleCTM | <ul><li>sx, sy: 2x `CGFloat`</li></ul> | The parameters are the factors used to scale in x/y-direction. |
| CGContextTranslateCTM | <ul><li>tx, ty: 2x `CGFloat`</li></ul> | The parameters are the amounts used to translate in x/y-direction. |
| CGColorSpaceCreateDeviceRGB | None | |
| CGColorSpaceRelease | <ul><li>colorSpace: `CGColorSpaceRef`</li></ul> | The parameter value is the reference to the color space created by `CGColorSpaceCreateDeviceRGB`. |
| CGGradientCreateWithColors | <ul><li>colors: 2x `CGColor`</li> <li>locations: 2x `CGFloat`</li></ul> | Currently supports only two colors. The color space currently always is RGB. |
| CGGradientRelease | <ul><li>gradient: `CGGradientRef`</li></ul> | The parameter value is the reference to the gradient created by `CGGradientCreateWithColors`. |
| CGContextDrawLinearGradient | <ul><li>gradient: `CGGradientRef`</li> <li>startPoint: `CGPoint`</li> <li>endPoint: `CGPoint`</li><li>options: `CGGradientDrawingOptions`</li></ul> | Currently the options parameter value is always 0 (zero). |
| CGContextDrawRadialGradient | <ul><li>gradient: `CGGradientRef`</li> <li>startCenter: `CGPoint`</li> <li>startRadius: `CGFloat`</li> <li>endCenter: `CGPoint`</li> <li>endRadius: `CGFloat`</li><li>options: `CGGradientDrawingOptions`</li></ul> | Currently the options parameter value is always 0 (zero). |
| CGContextSaveGState | None | |
| CGContextRestoreGState | None | |
| CGContextClip | None | Currently this is used only to clip the gradient fill to the drawing path. |

Not covered so far, but should be:

* Constructing more paths than just arcs and rectangles
* Filling using the even-odd rule
* Clipping (other than being used for gradient filling)
* Drawing text

## Affine transformation notes

References:

- [1] https://developer.apple.com/documentation/corefoundation/cgaffinetransform
- [2] https://en.wikipedia.org/wiki/Affine_transformation#Image_transformation
- [3] https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/transform
- [4] https://drafts.csswg.org/css-transforms/#mathematical-description (referenced by the SVG standard)
- [5] https://en.wikipedia.org/wiki/Matrix_multiplication
- [6] https://upload.wikimedia.org/wikipedia/commons/2/2c/2D_affine_transformation_matrix.svg

The UI of this project depicts affine transformation parameters as shown in the Apple docs [1]. The translation transform parameters named `tx` and `ty` by Apple are equivalent to the parameters `e` and `f` in other documentations.

Here is how the transformation matrix is depicted in the various documentations:

```
Apple                     Wikipedia + MDN           SVG + CSS
documentation [1]         documentation [2] + [3]   documentation [4]
+-----------+             +-----------+             +---------------+
| a   b   0 |             | a   c   e |             | a   c   0   e |
| c   d   0 |             | b   d   f |             | b   d   0   f |
| tx  ty  1 |             | 0   0   1 |             | 0   0   1   0 |
+-----------+             +-----------+             | 0   0   0   1 |
                                                    +----------------
```

The reason why the Apple documentation represents the transformation matrix differently than the other documentations is that they represent a 2-D coordinate with a 1x3 matrix, whereas the other documentations represent a 2-D coordinate with a 3x1 matrix. The rules for matrix multiplications [5] therefore require that the transformation matrix must be re-ordered.

```
Apple documentation [1]
                          +-----------+
                          | a   b   0 |
[x'  y'  1] = [x  y  1] x | c   d   0 |
                          | tx  ty  1 |
                          +-----------+

Other documentations
+----+   +---+   +-----------+
| x' |   | x |   | a   c   e |
| y' | = | y | x | b   d   f |
| 1  |   | 1 |   | 0   0   1 |
+----+   +---+   +-----------+
```

Here is the formula how to calculate a new coordinate using Apple's transformation matrix:

```
x' = ax + cy + tx
y' = bx + dy + ty
```

Finally, as a quick reference, here are the transformation matrices that represent the three common transformations (translate, scale, rotate) as well as some less common transformations. Source is [6].

```                                  
Translate by     Scale by
tx and ty        sx and sy
+-----------+    +-----------+
| 1   0   0 |    | sx  0   0 |
| 0   1   0 |    | 0   sy  0 |
| tx  ty  1 |    | 0   0   1 |
+-----------+    +-----------+

Rotate by angle θ
Positive angle = counter-clockwise rotation
Negative angle = clockwise rotation
+------------------+
| cos θ   sin θ  0 |
| -sin θ  cos θ  0 |
| 0       0      1 |
+------------------+

Shear parallel to    Shear parallel to
x-axis by angle ϕ    y-axis by angle ψ
+-------------+      +-------------+
| 1      0  0 |      | 1  tan ψ  0 |
| tan ϕ  1  0 |      | 0  1      0 |
| 0      0  1 |      | 0      0  1 |
+-------------+      +-------------+

Reflect about        Reflect about       Reflect about
origin               x-axis              y-axis
+-----------+        +----------+        +----------+
| -1  0   0 |        | 1  0   0 |        | -1  0  0 |
| 0   -1  0 |        | 0  -1  0 |        | 0   1  0 |
| 0   0   1 |        | 0  0   1 |        | 0   0  1 |
+-----------+        +----------+        +----------+
```