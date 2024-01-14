//
//  BoardPositionCollectionViewCell.m
//  boardpositioncollectionviewcell-layout
//
//  Created by Patrick Näf Moser on 14.01.2024.
//

#import "BoardPositionCollectionViewCell.h"
#import "AutoLayoutUtility.h"

static CGFloat nodeSymbolImageDimension = 43 * 0.7f;
static CGFloat iconImageDimension = 43 * 0.3f;

// ----------------------------------------
// Margins towards the superview edges
// ----------------------------------------
// 4 is not enough => the subviews are too close to the left/right cell edges
// - if horizontalSpacingSiblings == 4 => 6 is good
// - if horizontalSpacingSiblings == 8 => 8 is good
static int horizontalMargin = 8.0f;
// 4 is stingy, but still OK
// 8 is generous, also ok but not needed
// 6 is a good middle ground => tested with horizontalMargin = 6 and 8
static int verticalMargin = 6.0f;

// ----------------------------------------
// Spacings between siblings
// ----------------------------------------
// 4 is not enough, the labels are too close to the node symbol and the icon
//                  images are also too close to each other
// 6 is stingy
// 8 is generous and also looks good
static int horizontalSpacingSiblings = 8.0f;
// if horizontalSpacingSiblings == 4
// - 0 is very tight for the labels but OK - but it's not enough for the icons
//                   the icons are then too close to each other vertically
// - 2 is ok for the labels and a bit stingy for the icons
// - 4 is too much for the labels and OK for the icons
// if horizontalSpacingSiblings == 8
// - 4 is good
static int verticalSpacingLabels = 4.0f;
// 4 is not enough => the icons sit too close on top of each other
// 8 is too much => the icons are too close to the top/bottom cell edges
// 6 is a good middle ground
static int verticalSpacingIconImageViews = 6.0f;

// ----------------------------------------
// Fonts
// ----------------------------------------
// Cell height 42, Margin/Spacing 8: 14 allows 2 lines, 15+ allows only 1 line
// Cell height 42, Margin/Spacing 4: 17 allows 2 lines, 18+ allows only 1 line
// Cell height 50, vertical margin 6 / vertical spacing labels 4: 15 allows 2 lines, 16+ allows only 1 line
// Cell height 53, vertical margin 6 / vertical spacing labels 4: 17 allows 2 lines, 18+ allows only 1 line
static CGFloat largeFontSize = 17.0f;
static CGFloat smallFontSize = 11.0f;

@interface BoardPositionCellView()
@property (strong, nonatomic) UIImage* nodeSymbolImage;
@property (strong, nonatomic) UIImageView* nodeSymbolImageView;
@property (strong, nonatomic) UILabel* textLabel;
@property (strong, nonatomic) UILabel* detailTextLabel;
@property (strong, nonatomic) UILabel* capturedStonesLabel;
@property (strong, nonatomic) UIImage* hotspotIconImage;
@property (strong, nonatomic) UIImageView* hotspotIconImageView;
@property (strong, nonatomic) UIImage* infoIconImage;
@property (strong, nonatomic) UIImageView* infoIconImageView;
@property (strong, nonatomic) UIImage* markupIconImage;
@property (strong, nonatomic) UIImageView* markupIconImageView;

@property (strong, nonatomic) NSLayoutConstraint* detailTextLabelYPositionConstraint;
@property (strong, nonatomic) NSLayoutConstraint* detailTextLabelZeroHeightConstraint;

@property (strong, nonatomic) NSLayoutConstraint* capturedStonesLabelZeroWidthConstraint;

@property (strong, nonatomic) NSLayoutConstraint* infoIconImageViewLeftEdgeConstraint;
@property (strong, nonatomic) NSLayoutConstraint* infoIconImageViewWidthConstraint;

@property (strong, nonatomic) NSLayoutConstraint* hotspotIconImageViewWidthConstraint;

@property (strong, nonatomic) NSLayoutConstraint* markupIconImageViewLeftEdgeConstraint;
@property (strong, nonatomic) NSLayoutConstraint* markupIconImageViewWidthConstraint;

@property (strong, nonatomic) NSLayoutConstraint* infoIconImageViewXPositionConstraint;
@property (strong, nonatomic) NSLayoutConstraint* infoIconImageViewYPositionConstraint;
@property (strong, nonatomic) NSLayoutConstraint* hotspotIconImageViewYPositionConstraint;
@property (strong, nonatomic) NSLayoutConstraint* markupIconImageViewXPositionConstraint;
@property (strong, nonatomic) NSLayoutConstraint* markupIconImageViewYPositionConstraint;

@property (strong, nonatomic) NSLayoutConstraint* contentWidthConstraint;
@property (strong, nonatomic) NSLayoutConstraint* contentHeightConstraint;
@property (strong, nonatomic) NSLayoutConstraint* equalHeightsConstraint;
@end

@implementation BoardPositionCellView

#pragma mark - Initialization, deallocation

- (instancetype) initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (! self)
    return nil;

  _useBackgroundColors = true;
  _showDetailText = true;
  _showCapturedStones = true;
  _showHotspotIcon = true;
  _showInfoIcon = true;
  _showMarkupIcon = true;
  _activateEqualHeightsConstraint = false;

  // This flag decides how we control a view's visibility.
  // - If the flag is true then we don't touch the view's content and instead
  //   the view's hidden property to control visibility.
  // - If the flag is false we remove the view's content (set an image view's
  //   image to nil, set a label's text to nil) to control visibility. With this
  //   approach we rely on the view taking the appropriate steps to not render
  //   anything.
  //
  // In both cases when an icon should not be shown we also set the UIImageView's
  // width (via auto layout constraint) to zero so that other views are arranged
  // correctly. If the hidden property is not used, then it is vital that the
  // UIImageView's image property is set to nil, otherwise the UIImageView will
  // still show the image because the UIImageView does not have clipsToBounds set
  // to YES.
  _useHiddenProperty = false;

  // The contentSize can be used in two ways
  // - Return the size from the method intrinsicContentSize(). For this, set
  //   activateContentSizeConstraints to false and uncomment the method
  //   intrinsicContentSize().
  // - Set two auto layout constraints with the width/height in
  //   contentSize. For this, set activateContentSizeConstraints to true and
  //   comment the method intrinsicContentSize().
  //
  // To not use contentSize at all and let auto layout calculate the size fully
  // dynamically (as it would when off-screen layouting), set
  // activateContentSizeConstraints to false and comment the method
  // intrinsicContentSize(). This can be used to find a new value for
  // contentSize - when the app runs in the simulator, debug into the view
  // hierarchy and print a view description to see the size calculated by auto
  // layout.
  _activateContentSizeConstraints = true;
  // The last time we let auto layout calculate the size we got the following:
  // - self.equalHeightsConstraint = false => 189.0f / 50.0f
  // - self.equalHeightsConstraint = true => 189.0f / 57.0f
  // Set different sizes to experiment how the constraints behave when the cell
  // is wider/higher than what is required.
  _contentSize = CGSizeMake(189.0f, 50.0f);

  // Other possible values: Q88, Pass, Setup, Empty
  _text = @"Game start";
  // Other possible values: Move 8888
  _detailText = @"H: 99, K: 99½";
  _capturedStones = @"888";

  return self;
}

#pragma mark - Layout

- (void) layoutSubviews
{
  [super layoutSubviews];

  static bool isFirstLayoutSubviews = true;

  if (isFirstLayoutSubviews)
  {
    isFirstLayoutSubviews = false;

    self.layer.borderWidth = 1.0f;

    [self createImages];
    [self createSubviews];
    [self setIdentifiers];

    [self layoutFonts];
    [self layoutColors];
    [self layoutContentMode];

    [self updateBackgroundColors];

    [self addSubviewsAndSetupForAutolayout];

    [self setupStaticAutoLayoutConstraints];
  }

  [self updateDynamicConstraints];
}

#pragma mark - One-time setup without constraints

- (void) createImages
{
  self.nodeSymbolImage = [self imageWithName:@"stone-black.png" dimension:nodeSymbolImageDimension];
  self.hotspotIconImage = [self imageWithName:@"hotspot.png" dimension:iconImageDimension];
  self.infoIconImage = [self imageWithName:@"about.png" dimension:iconImageDimension];
  self.markupIconImage = [self imageWithName:@"markup.png" dimension:iconImageDimension];
}

- (void) createSubviews
{
  self.nodeSymbolImageView = [[UIImageView alloc] initWithImage:self.nodeSymbolImage];
  self.textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.detailTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.capturedStonesLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  self.hotspotIconImageView = [[UIImageView alloc] initWithImage:self.hotspotIconImage];
  self.infoIconImageView = [[UIImageView alloc] initWithImage:self.infoIconImage];
  self.markupIconImageView = [[UIImageView alloc] initWithImage:self.markupIconImage];

  self.textLabel.text = self.text;

  if (self.showDetailText)
    self.detailTextLabel.text = self.detailText;
  else
    self.detailTextLabel.text = nil;

  if (self.showCapturedStones)
    self.capturedStonesLabel.text = self.capturedStones;
  else
    self.capturedStonesLabel.text = nil;
}

- (void) setIdentifiers
{
  // Setting identifiers is extremely helpful when debugging auto layout issues
  self.accessibilityIdentifier = @"CellView";
  self.nodeSymbolImageView.accessibilityIdentifier = @"NodeSymbolImageView";
  self.textLabel.accessibilityIdentifier = @"TextLabel";
  self.detailTextLabel.accessibilityIdentifier = @"DetailTextLabel";
  self.capturedStonesLabel.accessibilityIdentifier = @"CapturedStonesLabel";
  self.hotspotIconImageView.accessibilityIdentifier = @"HotspotIconImageView";
  self.infoIconImageView.accessibilityIdentifier = @"InfoIconImageView";
  self.markupIconImageView.accessibilityIdentifier = @"MarkupIconImageView";
}

- (void) layoutFonts
{
  UIFont* largeFont = [UIFont systemFontOfSize:largeFontSize];
  UIFont* smallFont = [UIFont systemFontOfSize:smallFontSize];
  self.textLabel.font = largeFont;
  self.detailTextLabel.font = smallFont;
  self.capturedStonesLabel.font = smallFont;
}

- (void) layoutColors
{
  self.capturedStonesLabel.textColor = [UIColor redColor];
}

- (void) layoutContentMode
{
  self.nodeSymbolImageView.contentMode = UIViewContentModeCenter;
  self.hotspotIconImageView.contentMode = UIViewContentModeCenter;
  self.infoIconImageView.contentMode = UIViewContentModeCenter;
  self.markupIconImageView.contentMode = UIViewContentModeCenter;
}

- (UIImage*) imageWithName:(NSString*)imageName dimension:(CGFloat)dimension
{
  UIImage* image = [UIImage imageNamed:imageName];

  CGSize currentSize = image.size;

  CGSize newSize;
  if (currentSize.width == currentSize.height)
  {
    newSize = CGSizeMake(dimension, dimension);
  }
  else
  {
    CGFloat largerDimension = MAX(currentSize.width, currentSize.height);
    CGFloat aspectRatio = dimension / largerDimension;

    newSize = CGSizeMake(currentSize.width * aspectRatio,
                         currentSize.height * aspectRatio);
  }

  if (CGSizeEqualToSize(currentSize, newSize))
    return image;
  else
    return [self image:image byResizingToSize:newSize];

}

- (UIImage*) image:(UIImage*)image byResizingToSize:(CGSize)newSize
{
  UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
  CGRect resizedImageRect = CGRectMake(0, 0, newSize.width, newSize.height);
  [image drawInRect:resizedImageRect];
  UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return resizedImage;
}

- (void) addSubviewsAndSetupForAutolayout
{
  [self addSubview:self.nodeSymbolImageView];
  [self addSubview:self.textLabel];
  [self addSubview:self.detailTextLabel];
  [self addSubview:self.capturedStonesLabel];
  [self addSubview:self.hotspotIconImageView];
  [self addSubview:self.infoIconImageView];
  [self addSubview:self.markupIconImageView];

  self.nodeSymbolImageView.translatesAutoresizingMaskIntoConstraints = NO;
  self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.detailTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.capturedStonesLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.hotspotIconImageView.translatesAutoresizingMaskIntoConstraints = NO;
  self.infoIconImageView.translatesAutoresizingMaskIntoConstraints = NO;
  self.markupIconImageView.translatesAutoresizingMaskIntoConstraints = NO;
}

#pragma mark - One-time setup - static constraints

- (void) setupStaticAutoLayoutConstraints
{
  [self setupStaticAutoLayoutConstraintsContentSize];
  [self setupStaticAutoLayoutConstraintsNodeSymbolImageView];
  [self setupStaticAutoLayoutConstraintsTextLabel];
  [self setupStaticAutoLayoutConstraintsDetailTextLabel];
  [self setupStaticAutoLayoutConstraintsCapturedStonesLabel];
  [self setupStaticAutoLayoutConstraintsInfoIconImageView];
  [self setupStaticAutoLayoutConstraintsHotspotIconImageView];
  [self setupStaticAutoLayoutConstraintsMarkupIconImageView];
}

// ----------------------------------------
// Content size
// ----------------------------------------
- (void) setupStaticAutoLayoutConstraintsContentSize
{
  self.contentWidthConstraint = [NSLayoutConstraint constraintWithItem:self
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1.0
                                                              constant:self.contentSize.width];
  self.contentWidthConstraint.active = (self.activateContentSizeConstraints
                                        ? YES
                                        : NO);
  self.contentWidthConstraint.identifier = @"ContentWidth";

  self.contentHeightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0
                                                               constant:self.contentSize.height];
  self.contentHeightConstraint.active = (self.activateContentSizeConstraints
                                         ? YES
                                         : NO);
  self.contentHeightConstraint.identifier = @"ContentWidth";
}

// ----------------------------------------
// nodeSymbolImageView
// ----------------------------------------
- (void) setupStaticAutoLayoutConstraintsNodeSymbolImageView
{
  NSDictionary* viewsDictionary = [self viewsDictionary];
  NSMutableArray* visualFormats = [NSMutableArray array];

  // C000
  [visualFormats addObject:[NSString stringWithFormat:@"H:|-%d-[nodeSymbolImageView]", horizontalMargin]];
  // C001
  NSLayoutConstraint* constraint = [AutoLayoutUtility alignFirstView:self.nodeSymbolImageView
                                                      withSecondView:self
                                                         onAttribute:NSLayoutAttributeCenterY
                                                    constraintHolder:self];
  constraint.identifier = @"C001";
  // C002
  [visualFormats addObject:[NSString stringWithFormat:@"H:[nodeSymbolImageView(==%f)]", nodeSymbolImageDimension]];
  // C003
  [visualFormats addObject:[NSString stringWithFormat:@"V:[nodeSymbolImageView(==%f)]", nodeSymbolImageDimension]];

  NSArray* constraints = [AutoLayoutUtility installVisualFormats:visualFormats withViews:viewsDictionary inView:self];
  [self throwIfConstraints:constraints hasNotExpectedCount:3];
  ((NSLayoutConstraint*)constraints[0]).identifier = @"C000";
  ((NSLayoutConstraint*)constraints[1]).identifier = @"C002";
  ((NSLayoutConstraint*)constraints[2]).identifier = @"C003";
}

// ----------------------------------------
// textLabel
// ----------------------------------------
- (void) setupStaticAutoLayoutConstraintsTextLabel
{
  NSDictionary* viewsDictionary = [self viewsDictionary];
  NSMutableArray* visualFormats = [NSMutableArray array];

  // C010
  [visualFormats addObject:[NSString stringWithFormat:@"H:[nodeSymbolImageView]-%d-[textLabel]", horizontalSpacingSiblings]];
  // C011
  [visualFormats addObject:[NSString stringWithFormat:@"V:|-%d-[textLabel]", verticalMargin]];

  // C012 width = C030
  // C013 height = C023
  // C014 numberOfLines = 1 (the default)
  // C015 horizontal text alignment = default (left)
  // C016 vertical text alignment = default (center)

  NSArray* constraints = [AutoLayoutUtility installVisualFormats:visualFormats withViews:viewsDictionary inView:self];
  [self throwIfConstraints:constraints hasNotExpectedCount:2];
  ((NSLayoutConstraint*)constraints[0]).identifier = @"C010";
  ((NSLayoutConstraint*)constraints[1]).identifier = @"C011";
}

// ----------------------------------------
// detailTextLabel
// ----------------------------------------
- (void) setupStaticAutoLayoutConstraintsDetailTextLabel
{
  NSDictionary* viewsDictionary = [self viewsDictionary];
  NSMutableArray* visualFormats = [NSMutableArray array];

  // C020
  [visualFormats addObject:[NSString stringWithFormat:@"H:[nodeSymbolImageView]-%d-[detailTextLabel]", horizontalSpacingSiblings]];
  // C021
  self.detailTextLabelYPositionConstraint = [NSLayoutConstraint constraintWithItem:self.detailTextLabel
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.textLabel
                                                                         attribute:NSLayoutAttributeBottom
                                                                        multiplier:1.0
                                                                          constant:verticalSpacingLabels];
  self.detailTextLabelYPositionConstraint.active = YES;
  self.detailTextLabelYPositionConstraint.identifier = @"C021";

  // C022 width = C050

  // C023
  [visualFormats addObject:[NSString stringWithFormat:@"V:[detailTextLabel]-%d-|", verticalMargin]];
  // C024
  self.detailTextLabelZeroHeightConstraint = [NSLayoutConstraint constraintWithItem:self.detailTextLabel
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1.0
                                                                           constant:0.0f];
  self.detailTextLabelZeroHeightConstraint.active = NO;
  self.detailTextLabelZeroHeightConstraint.identifier = @"C024";

  // C025 numberOfLines = 1 (the default)
  // C026 horizontal text alignment = default (left)
  // C027 vertical text alignment = default (center)

  // C028
  // If the cell is higher than required then without this constraint the detail
  // text label gets all the surplus height while the text label stays at the
  // minimum height. Activating the constraint makes sure that the two labels
  // get an equal share of the available height.
  self.equalHeightsConstraint = [AutoLayoutUtility alignFirstView:self.detailTextLabel
                                                   withSecondView:self.textLabel
                                                      onAttribute:NSLayoutAttributeHeight
                                                 constraintHolder:self];
  if (! self.activateEqualHeightsConstraint)
    self.equalHeightsConstraint.active = NO;
  self.equalHeightsConstraint.identifier = @"C028";

  NSArray* constraints = [AutoLayoutUtility installVisualFormats:visualFormats withViews:viewsDictionary inView:self];
  [self throwIfConstraints:constraints hasNotExpectedCount:2];
  ((NSLayoutConstraint*)constraints[0]).identifier = @"C020";
  ((NSLayoutConstraint*)constraints[1]).identifier = @"C023";
}

// ----------------------------------------
// capturedStonesLabel
// ----------------------------------------
- (void) setupStaticAutoLayoutConstraintsCapturedStonesLabel
{
  NSDictionary* viewsDictionary = [self viewsDictionary];
  NSMutableArray* visualFormats = [NSMutableArray array];

  // C030
  [visualFormats addObject:[NSString stringWithFormat:@"H:[textLabel]-%d-[capturedStonesLabel]", horizontalSpacingSiblings]];
  // C031
  NSLayoutConstraint* constraint = [AutoLayoutUtility alignFirstView:self.capturedStonesLabel
                                                      withSecondView:self.textLabel
                                                         onAttribute:NSLayoutAttributeCenterY
                                                    constraintHolder:self];
  constraint.identifier = @"C031";

  // C032 width = C040
  // C033 height = intrinsic height
  // C034 numberOfLines = 1 (the default)

  // C035
  self.capturedStonesLabel.textAlignment = NSTextAlignmentRight;

  // C036 vertical text alignment = default (center)

  // C032 in ORIGINAL - set to nil to initialize
  self.capturedStonesLabelZeroWidthConstraint = nil;

  NSArray* constraints = [AutoLayoutUtility installVisualFormats:visualFormats withViews:viewsDictionary inView:self];
  [self throwIfConstraints:constraints hasNotExpectedCount:1];
  ((NSLayoutConstraint*)constraints[0]).identifier = @"C030";
}

// ----------------------------------------
// infoIconImageView
// ----------------------------------------
- (void) setupStaticAutoLayoutConstraintsInfoIconImageView
{
  NSDictionary* viewsDictionary = [self viewsDictionary];
  NSMutableArray* visualFormats = [NSMutableArray array];

  // C040
  self.infoIconImageViewLeftEdgeConstraint = [NSLayoutConstraint constraintWithItem:self.infoIconImageView
                                                                          attribute:NSLayoutAttributeLeading
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.capturedStonesLabel
                                                                          attribute:NSLayoutAttributeTrailing
                                                                         multiplier:1.0
                                                                           constant:horizontalSpacingSiblings];
  self.infoIconImageViewLeftEdgeConstraint.active = YES;
  self.infoIconImageViewLeftEdgeConstraint.identifier = @"C040";

  // C041 - wholly defined in dynamic constraints

  // C042
  [visualFormats addObject:[NSString stringWithFormat:@"H:[infoIconImageView]-%d-|", horizontalMargin]];

  // C043
  // Start out with a non-zero width - the actual value will be updated
  // dynamically
  self.infoIconImageViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.infoIconImageView
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.0
                                                                        constant:iconImageDimension];
  self.infoIconImageViewWidthConstraint.active = YES;
  self.infoIconImageViewWidthConstraint.identifier = @"C043";

  // C044
  [visualFormats addObject:[NSString stringWithFormat:@"V:[infoIconImageView(==%f)]", iconImageDimension]];

  // C040 in ORIGINAL - set to nil to initialize
  self.infoIconImageViewXPositionConstraint = nil;

  NSArray* constraints = [AutoLayoutUtility installVisualFormats:visualFormats withViews:viewsDictionary inView:self];
  [self throwIfConstraints:constraints hasNotExpectedCount:2];
  ((NSLayoutConstraint*)constraints[0]).identifier = @"C042";
  ((NSLayoutConstraint*)constraints[1]).identifier = @"C044";
}

// ----------------------------------------
// hotspotIconImageView
// ----------------------------------------
- (void) setupStaticAutoLayoutConstraintsHotspotIconImageView
{
  NSDictionary* viewsDictionary = [self viewsDictionary];
  NSMutableArray* visualFormats = [NSMutableArray array];

  // C050
  [visualFormats addObject:[NSString stringWithFormat:@"H:[detailTextLabel]-%d-[hotspotIconImageView]", horizontalSpacingSiblings]];

  // C051 - wholly defined in dynamic constraints
  // C052 width = C060

  // C053
  // Start out with a non-zero width - the actual value will be updated
  // dynamically
  self.hotspotIconImageViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.hotspotIconImageView
                                                                          attribute:NSLayoutAttributeWidth
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1.0
                                                                           constant:iconImageDimension];
  self.hotspotIconImageViewWidthConstraint.active = YES;
  self.hotspotIconImageViewWidthConstraint.identifier = @"C053";

  // C054
  [visualFormats addObject:[NSString stringWithFormat:@"V:[hotspotIconImageView(==%f)]", iconImageDimension]];

  NSArray* constraints = [AutoLayoutUtility installVisualFormats:visualFormats withViews:viewsDictionary inView:self];
  [self throwIfConstraints:constraints hasNotExpectedCount:2];
  ((NSLayoutConstraint*)constraints[0]).identifier = @"C050";
  ((NSLayoutConstraint*)constraints[1]).identifier = @"C054";
}

// ----------------------------------------
// markupIconImageView
// ----------------------------------------
- (void) setupStaticAutoLayoutConstraintsMarkupIconImageView
{
  NSDictionary* viewsDictionary = [self viewsDictionary];
  NSMutableArray* visualFormats = [NSMutableArray array];

  // C060
  self.markupIconImageViewLeftEdgeConstraint = [NSLayoutConstraint constraintWithItem:self.markupIconImageView
                                                                          attribute:NSLayoutAttributeLeading
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.hotspotIconImageView
                                                                          attribute:NSLayoutAttributeTrailing
                                                                         multiplier:1.0
                                                                           constant:horizontalSpacingSiblings];
  self.markupIconImageViewLeftEdgeConstraint.active = YES;
  self.markupIconImageViewLeftEdgeConstraint.identifier = @"C060";

  // C061 - wholly defined in dynamic constraints

  // C062
  [visualFormats addObject:[NSString stringWithFormat:@"H:[markupIconImageView]-%d-|", horizontalMargin]];

  // C063
  // Start out with a non-zero width - the actual value will be updated
  // dynamically
  self.markupIconImageViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.markupIconImageView
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0
                                                                          constant:iconImageDimension];
  self.markupIconImageViewWidthConstraint.active = YES;
  self.markupIconImageViewWidthConstraint.identifier = @"C063";

  // C064
  [visualFormats addObject:[NSString stringWithFormat:@"V:[markupIconImageView(==%f)]", iconImageDimension]];

  // C060 in ORIGINAL - set to nil to initialize
  self.markupIconImageViewXPositionConstraint = nil;

  NSArray* constraints = [AutoLayoutUtility installVisualFormats:visualFormats withViews:viewsDictionary inView:self];
  [self throwIfConstraints:constraints hasNotExpectedCount:2];
  ((NSLayoutConstraint*)constraints[0]).identifier = @"C062";
  ((NSLayoutConstraint*)constraints[1]).identifier = @"C064";
}

#pragma mark - One-time setup - static constraints - Helpers

- (NSDictionary*) viewsDictionary
{
  return [NSDictionary dictionaryWithObjectsAndKeys:
          self.nodeSymbolImageView, @"nodeSymbolImageView",
          self.textLabel, @"textLabel",
          self.detailTextLabel, @"detailTextLabel",
          self.capturedStonesLabel, @"capturedStonesLabel",
          self.hotspotIconImageView, @"hotspotIconImageView",
          self.infoIconImageView, @"infoIconImageView",
          self.markupIconImageView, @"markupIconImageView",
          nil];
}

- (void) throwIfConstraints:(NSArray*)constraints
        hasNotExpectedCount:(NSUInteger)expectedCount
{
  if (constraints.count == expectedCount)
    return;

  @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:[NSString stringWithFormat:@"unexpected constraints count %lu, expected was %lu", (unsigned long)constraints.count, (unsigned long)expectedCount]
                               userInfo:nil];
}

#pragma mark - Repeated layout - dynamic constraints

- (void) updateDynamicConstraints
{
  // C021
  self.detailTextLabelYPositionConstraint.constant = self.showDetailText ? verticalSpacingLabels : 0.0f;
  // C024
  self.detailTextLabelZeroHeightConstraint.active = self.showDetailText ? NO : YES;

  // C040
  self.infoIconImageViewLeftEdgeConstraint.constant = self.showInfoIcon ? horizontalSpacingSiblings : 0;
  // C043
  self.infoIconImageViewWidthConstraint.constant = self.showInfoIcon ? iconImageDimension : 0.0f;

  // C053
  self.hotspotIconImageViewWidthConstraint.constant = self.showHotspotIcon ? iconImageDimension : 0.0f;

  // C060
  self.markupIconImageViewLeftEdgeConstraint.constant = self.showMarkupIcon ? horizontalSpacingSiblings : 0;
  // C063
  self.markupIconImageViewWidthConstraint.constant = self.showMarkupIcon ? iconImageDimension : 0.0f;

  UIView* alignViewTopRow;
  UIView* alignViewBottomRow;
  CGFloat constantTopRow;
  CGFloat constantBottomRow;
  if (self.showDetailText)
  {
    alignViewTopRow = self.textLabel;
    alignViewBottomRow = self.detailTextLabel;
    constantTopRow = 0.0f;
    constantBottomRow = 0.0f;
  }
  else
  {
    alignViewTopRow = self;
    alignViewBottomRow = self;

    if (self.showInfoIcon && (self.showHotspotIcon || self.showMarkupIcon))
    {
      CGFloat alignModifier = (iconImageDimension + verticalSpacingIconImageViews) / 2.0f;
      constantTopRow = -alignModifier;
      constantBottomRow = alignModifier;
    }
    else
    {
      constantTopRow = 0.0f;
      constantBottomRow = 0.0f;
    }
  }

  // C041
  if (self.infoIconImageViewYPositionConstraint)
    self.infoIconImageViewYPositionConstraint.active = NO;
  self.infoIconImageViewYPositionConstraint = [NSLayoutConstraint constraintWithItem:self.infoIconImageView
                                                                           attribute:NSLayoutAttributeCenterY
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:alignViewTopRow
                                                                           attribute:NSLayoutAttributeCenterY
                                                                          multiplier:1.0
                                                                            constant:constantTopRow];
  self.infoIconImageViewYPositionConstraint.active = YES;
  self.infoIconImageViewYPositionConstraint.identifier = @"C041";

  // C051
  if (self.hotspotIconImageViewYPositionConstraint)
    self.hotspotIconImageViewYPositionConstraint.active = NO;
  self.hotspotIconImageViewYPositionConstraint = [NSLayoutConstraint constraintWithItem:self.hotspotIconImageView
                                                                              attribute:NSLayoutAttributeCenterY
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:alignViewBottomRow
                                                                              attribute:NSLayoutAttributeCenterY
                                                                             multiplier:1.0
                                                                               constant:constantBottomRow];
  self.hotspotIconImageViewYPositionConstraint.active = YES;
  self.hotspotIconImageViewYPositionConstraint.identifier = @"C051";

  // C061
  if (self.markupIconImageViewYPositionConstraint)
    self.markupIconImageViewYPositionConstraint.active = NO;
  self.markupIconImageViewYPositionConstraint = [NSLayoutConstraint constraintWithItem:self.markupIconImageView
                                                                             attribute:NSLayoutAttributeCenterY
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:alignViewBottomRow
                                                                             attribute:NSLayoutAttributeCenterY
                                                                            multiplier:1.0
                                                                              constant:constantBottomRow];
  self.markupIconImageViewYPositionConstraint.active = YES;
  self.markupIconImageViewYPositionConstraint.identifier = @"C061";
}

#pragma mark - Setters

- (void) setText:(NSString*)text
{
  _text = text;
  [self updateText];
}

- (void) setDetailText:(NSString*)detailText
{
  _detailText = detailText;
  [self updateDetailText];
}

- (void) setCapturedStones:(NSString*)capturedStones
{
  _capturedStones = capturedStones;
  [self updateCapturedStones];
}

- (void) setUseBackgroundColors:(bool)useBackgroundColors
{
  _useBackgroundColors = useBackgroundColors;
  [self updateBackgroundColors];
}

- (void) setShowDetailText:(bool)showDetailText
{
  _showDetailText = showDetailText;
  [self updateShowDetailText];
}

- (void) setShowCapturedStones:(bool)showCapturedStones
{
  _showCapturedStones = showCapturedStones;
  [self updateShowCapturedStones];
}

- (void) setShowHotspotIcon:(bool)showHotspotIcon
{
  _showHotspotIcon = showHotspotIcon;
  [self updateShowHotspotIcon];
}

- (void) setShowInfoIcon:(bool)showInfoIcon
{
  _showInfoIcon = showInfoIcon;
  [self updateShowInfoIcon];
}

- (void) setShowMarkupIcon:(bool)showMarkupIcon
{
  _showMarkupIcon = showMarkupIcon;
  [self updateShowMarkupIcon];
}

- (void) setActivateEqualHeightsConstraint:(bool)activateEqualHeightsConstraint
{
  _activateEqualHeightsConstraint = activateEqualHeightsConstraint;
  [self updateActivateEqualHeightsConstraint];
}

- (void) setUseHiddenProperty:(bool)useHiddenProperty
{
  _useHiddenProperty = useHiddenProperty;
  [self updateUseHiddenProperty];
}

- (void) setActivateContentSizeConstraints:(bool)activateContentSizeConstraints
{
  _activateContentSizeConstraints = activateContentSizeConstraints;
  [self updateActivateContentSizeConstraints];
}

- (void) setContentSize:(CGSize)contentSize
{
  _contentSize = contentSize;
  [self updateContentSize];
}

#pragma mark - Updaters

- (void) updateText
{
  self.textLabel.text = self.text;
}

- (void) updateDetailText
{
  // If the label is visible then we have to update its text, of course.
  // If the label is not visible, then we may only update its text if we used
  // the hidden property for making the label not visible. If instead we set the
  // label text to nil to make it not visible, then of course we may not now set
  // the label text, because that would make the label visible.
  if (self.showDetailText || self.useHiddenProperty)
  {
    self.detailTextLabel.text = self.detailText;
    [self setNeedsLayout];
  }
}

- (void) updateCapturedStones
{
  // If the label is visible then we have to update its text, of course.
  // If the label is not visible, then we may only update its text if we used
  // the hidden property for making the label not visible. If instead we set the
  // label text to nil to make it not visible, then of course we may not now set
  // the label text, because that would make the label visible.
  if (self.showCapturedStones || self.useHiddenProperty)
  {
    self.capturedStonesLabel.text = self.capturedStones;
    [self setNeedsLayout];
  }
}

- (void) updateBackgroundColors
{
  if (self.useBackgroundColors)
  {
    self.nodeSymbolImageView.backgroundColor = [UIColor redColor];
    self.textLabel.backgroundColor = [UIColor greenColor];
    self.detailTextLabel.backgroundColor = [UIColor yellowColor];
    self.capturedStonesLabel.backgroundColor = [UIColor lightGrayColor];
    self.hotspotIconImageView.backgroundColor = [UIColor systemTealColor];
    self.infoIconImageView.backgroundColor = [UIColor orangeColor];
    self.markupIconImageView.backgroundColor = [UIColor cyanColor];
  }
  else
  {
    self.nodeSymbolImageView.backgroundColor = [UIColor clearColor];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
    self.capturedStonesLabel.backgroundColor = [UIColor clearColor];
    self.hotspotIconImageView.backgroundColor = [UIColor clearColor];
    self.infoIconImageView.backgroundColor = [UIColor clearColor];
    self.markupIconImageView.backgroundColor = [UIColor clearColor];
  }
}

- (void) updateShowDetailText
{
  if (self.showDetailText)
  {
    if (self.useHiddenProperty)
      self.detailTextLabel.hidden = NO;
    else
      self.detailTextLabel.text = self.detailText;
  }
  else
  {
    if (self.useHiddenProperty)
      self.detailTextLabel.hidden = YES;
    else
      self.detailTextLabel.text = nil;
  }
  [self setNeedsLayout];
}

- (void) updateShowCapturedStones
{
  if (self.showCapturedStones)
  {
    if (self.useHiddenProperty)
      self.capturedStonesLabel.hidden = NO;
    else
      self.capturedStonesLabel.text = self.capturedStones;
  }
  else
  {
    if (self.useHiddenProperty)
      self.capturedStonesLabel.hidden = YES;
    else
      self.capturedStonesLabel.text = nil;
  }
  [self setNeedsLayout];
}

- (void) updateShowHotspotIcon
{
  if (self.showHotspotIcon)
  {
    if (self.useHiddenProperty)
      self.hotspotIconImageView.hidden = NO;
    else
      self.hotspotIconImageView.image = self.hotspotIconImage;
  }
  else
  {
    if (self.useHiddenProperty)
      self.hotspotIconImageView.hidden = YES;
    else
      self.hotspotIconImageView.image = nil;
  }
  [self setNeedsLayout];
}

- (void) updateShowInfoIcon
{
  if (self.showInfoIcon)
  {
    if (self.useHiddenProperty)
      self.infoIconImageView.hidden = NO;
    else
      self.infoIconImageView.image = self.infoIconImage;
  }
  else
  {
    if (self.useHiddenProperty)
      self.infoIconImageView.hidden = YES;
    else
      self.infoIconImageView.image = nil;
  }
  [self setNeedsLayout];
}

- (void) updateShowMarkupIcon
{
  if (self.showMarkupIcon)
  {
    if (self.useHiddenProperty)
      self.markupIconImageView.hidden = NO;
    else
      self.markupIconImageView.image = self.markupIconImage;
  }
  else
  {
    if (self.useHiddenProperty)
      self.markupIconImageView.hidden = YES;
    else
      self.markupIconImageView.image = nil;
  }
  [self setNeedsLayout];
}

- (void) updateActivateEqualHeightsConstraint
{
  self.equalHeightsConstraint.active = (self.activateEqualHeightsConstraint
                                        ? YES
                                        : NO);
  [self setNeedsLayout];
}

- (void) updateUseHiddenProperty
{
  [self updateShowDetailText];
  [self updateShowCapturedStones];
  [self updateShowHotspotIcon];
  [self updateShowInfoIcon];
  [self updateShowMarkupIcon];
  [self setNeedsLayout];
}

- (void) updateActivateContentSizeConstraints
{
  self.contentWidthConstraint.active = (self.activateContentSizeConstraints
                                        ? YES
                                        : NO);
  self.contentHeightConstraint.active = (self.activateContentSizeConstraints
                                         ? YES
                                         : NO);
  [self setNeedsLayout];
}

- (void) updateContentSize
{
  self.contentWidthConstraint.constant = self.contentSize.width;
  self.contentHeightConstraint.constant = self.contentSize.height;
  [self setNeedsLayout];
}

//- (CGSize) intrinsicContentSize
//{
//  return self.contentSize;
//}

@end
