//
//  DrawingParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 25.03.23.
//

#import "DrawingParametersViewController.h"
#import "DrawingParametersItemViewController.h"
#import "../../Model/Drawing/DrawingParameters.h"
#import "../../Model/Drawing/DrawingParametersItem.h"
#import "../../AutoLayoutUtility.h"
#import "../../Converter.h"
#import "../../ParametersHelper.h"

static NSString* reusableCellIdentifier = @"DrawingParametersItem";

@interface DrawingParametersViewController()
@property (weak, nonatomic) IBOutlet UITableView* itemsTableView;
@property (weak, nonatomic) IBOutlet UIView* detailContainerView;
@property (nonatomic) NSUInteger indexOfSelectedDrawingParametersItem;
// Keep a strong reference so that we can remove the KVO observer registration
// even after the item is no longer retained by its parent DrawingParameters
@property (strong, nonatomic) DrawingParametersItem* selectedDrawingParametersItem;
@end

@implementation DrawingParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithDrawingParameters:(DrawingParameters*)drawingParameters
{
  self = [super initWithNibName:@"DrawingParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (drawingParameters)
    self.drawingParameters = drawingParameters;
  else
    self.drawingParameters = [[DrawingParameters alloc] init];

  return self;
}

- (void) dealloc
{
  if (self.selectedDrawingParametersItem)
    [self stopObservingDrawingParametersItem:self.selectedDrawingParametersItem];
}

#pragma mark - UIViewController methods

- (void) viewDidLoad
{
  [super viewDidLoad];

  [self integrateChildViewControllers];
  [self updateUiWithModelValues];
}

#pragma mark - Manage child view controllers

- (void) integrateChildViewControllers
{
  DrawingParametersItemViewController* drawingParametersItemViewController = [[DrawingParametersItemViewController alloc] init];

  [self addChildViewController:drawingParametersItemViewController];
  [drawingParametersItemViewController didMoveToParentViewController:self];

  UIView* drawingParametersItemView = drawingParametersItemViewController.view;
  [self.detailContainerView addSubview:drawingParametersItemView];
  drawingParametersItemView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.detailContainerView withSubview:drawingParametersItemView];
}

#pragma mark - Button interactions - Drawing items

- (IBAction) addButtonTapped:(UIButton*)sender
{
  NSUInteger insertPosition = self.indexOfSelectedDrawingParametersItem + 1;
  NSUInteger indexOfInsertedItem = [self.drawingParameters insertItemAt:insertPosition];

  [self.itemsTableView reloadData];

  [self updateSelectedDrawingParametersItem:indexOfInsertedItem];
  [self updateCellSelection];
  [self updateDetailsView];
}

- (IBAction) removeButtonTapped:(UIButton*)sender
{
  NSUInteger indexOfItemToRemove = self.indexOfSelectedDrawingParametersItem;
  bool success = [self.drawingParameters removeItemAt:indexOfItemToRemove];
  if (! success)
    return;

  [self.itemsTableView reloadData];

  NSUInteger numberOfItemsAfterRemoval = self.drawingParameters.drawingParametersItems.count;
  NSUInteger indexOfNewlySelectedItem = (indexOfItemToRemove < numberOfItemsAfterRemoval
                                         ? indexOfItemToRemove
                                         : numberOfItemsAfterRemoval - 1);
  [self updateSelectedDrawingParametersItem:indexOfNewlySelectedItem];
  [self updateCellSelection];
  [self updateDetailsView];
}

- (IBAction) moveUpButtonTapped:(UIButton*)sender
{
  NSUInteger indexOfItemToMoveUp = self.indexOfSelectedDrawingParametersItem;
  bool success = [self.drawingParameters moveUpItemAt:indexOfItemToMoveUp];
  if (! success)
    return;

  [self.itemsTableView reloadData];

  NSUInteger indexOfNewlySelectedItem = indexOfItemToMoveUp - 1;
  [self updateSelectedDrawingParametersItem:indexOfNewlySelectedItem];
  [self updateCellSelection];
}

- (IBAction) moveDownButtonTapped:(UIButton*)sender
{
  NSUInteger indexOfItemToMoveDown = self.indexOfSelectedDrawingParametersItem;
  bool success = [self.drawingParameters moveDownItemAt:indexOfItemToMoveDown];
  if (! success)
    return;

  [self.itemsTableView reloadData];

  NSUInteger indexOfNewlySelectedItem = indexOfItemToMoveDown + 1;
  [self updateSelectedDrawingParametersItem:indexOfNewlySelectedItem];
  [self updateCellSelection];
}

#pragma mark - Button interactions - Changing drawing parameters

- (IBAction) saveButtonTapped:(UIButton*)sender
{
  [ParametersHelper saveParameters:self.drawingParameters];
}

- (IBAction) loadButtonTapped:(UIButton*)sender
{
  [ParametersHelper loadParameters:self.drawingParameters];
  [self updateUiWithModelValues];
}

- (IBAction) resetButtonTapped:(UIButton*)sender
{
  [ParametersHelper resetParameters:self.drawingParameters];
  [self updateUiWithModelValues];
}

- (IBAction) alignGradientToPathButtonTapped:(UIButton*)sender
{
  if (! self.selectedDrawingParametersItem)
    return;

  [ParametersHelper alignGradientToPathParameters:self.selectedDrawingParametersItem];

  for (id childViewController in self.childViewControllers)
    [childViewController updateUiWithModelValues];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView
{
  return 1;
}

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.drawingParameters.drawingParametersItems.count;
}

- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
  DrawingParametersItem* drawingParametersItem = [self drawingParametersItemAtIndex:indexPath.row];
  if (! drawingParametersItem)
    return nil;

  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reusableCellIdentifier];
  if (! cell)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:reusableCellIdentifier];
  }

  cell.textLabel.text = drawingParametersItem.itemAsString;
  cell.detailTextLabel.text = drawingParametersItem.itemDetailsAsString;

  return cell;
}

#pragma mark - UITableViewDelegate methods

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
  [self updateSelectedDrawingParametersItem:indexPath.row];
  [self updateDetailsView];
}

#pragma mark - UITextFieldDelegate methods

- (BOOL) textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
  return NO;
}

#pragma mark - Updaters

- (void) updateUiWithModelValues
{
  [self.itemsTableView reloadData];

  // How selection works:
  // - In general the table view manages cell selection without programmatic
  //   intervention. Important is that the table view's default property values
  //   allow selection (allowsSelection = YES) and prevent multi-selection
  //   (allowsMultipleSelection = NO).
  // - When the user interactively changes the selection, the table view invokes
  //   the delegate method tableView:didSelectRowAtIndexPath:(). This is
  //   implemented to invoke updateDetailsView().
  // - To change the selection programmaticaly the table view method
  // - selectRowAtIndexPath:animated:scrollPosition:() must be invoked. This
  //   does not invoke the delegate method tableView:didSelectRowAtIndexPath:(),
  //   which means that updateDetailsView() must be invoked in addition.
  NSUInteger indexOfItem = (self.drawingParameters.drawingParametersItems.count > 0
                            ? 0
                            : -1);
  [self updateSelectedDrawingParametersItem:indexOfItem];
  [self updateCellSelection];
  [self updateDetailsView];
}

- (void) updateSelectedDrawingParametersItem:(NSUInteger)indexOfDrawingParametersItem
{
  // Don't try to optimize by comparing the old/new index - when removing an
  // item the old/new index could be the same, but the old/new item is not

  if (self.selectedDrawingParametersItem)
    [self stopObservingDrawingParametersItem:self.selectedDrawingParametersItem];

  self.indexOfSelectedDrawingParametersItem = indexOfDrawingParametersItem;
  self.selectedDrawingParametersItem = [self drawingParametersItemAtIndex:self.indexOfSelectedDrawingParametersItem];

  if (self.selectedDrawingParametersItem)
    [self startObservingDrawingParametersItem:self.selectedDrawingParametersItem];
}

- (DrawingParametersItem*) drawingParametersItemAtIndex:(NSUInteger)indexOfDrawingParametersItem
{
  NSArray* drawingParametersItems = self.drawingParameters.drawingParametersItems;
  if (indexOfDrawingParametersItem < drawingParametersItems.count)
    return [drawingParametersItems objectAtIndex:indexOfDrawingParametersItem];
  else
    return nil;
}

- (void) updateCellSelection
{
  if (self.indexOfSelectedDrawingParametersItem == -1)
    return;

  NSIndexPath* indexPath = [NSIndexPath indexPathForRow:self.indexOfSelectedDrawingParametersItem
                                              inSection:0];

  // The table view does ***not*** invoke tableView:didSelectRowAtIndexPath: on
  // the delegate => the caller must also invoke updateDetailsView
  [self.itemsTableView selectRowAtIndexPath:indexPath
                                        animated:YES
                                  scrollPosition:UITableViewScrollPositionMiddle];
}

- (void) updateDetailsView
{
  DrawingParametersItem* drawingParametersItem = [self drawingParametersItemAtIndex:self.indexOfSelectedDrawingParametersItem];

  DrawingParametersItemViewController* drawingParametersItemViewController = self.childViewControllers.firstObject;
  [drawingParametersItemViewController updateDrawingParametersItem:drawingParametersItem];
}

#pragma mark - KVO

- (void) startObservingDrawingParametersItem:(DrawingParametersItem*)drawingParametersItem
{
  [drawingParametersItem addObserver:self forKeyPath:@"itemAsString" options:0 context:NULL];
  [drawingParametersItem addObserver:self forKeyPath:@"itemDetailsAsString" options:0 context:NULL];
}

- (void) stopObservingDrawingParametersItem:(DrawingParametersItem*)drawingParametersItem
{
  [drawingParametersItem removeObserver:self forKeyPath:@"itemAsString"];
  [drawingParametersItem removeObserver:self forKeyPath:@"itemDetailsAsString"];
}

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
  NSUInteger indexOfDrawingParametersItem = [self.drawingParameters.drawingParametersItems indexOfObject:object];
  if (indexOfDrawingParametersItem == NSNotFound)
    return;

  NSIndexPath* indexPath = [NSIndexPath indexPathForRow:indexOfDrawingParametersItem
                                              inSection:0];
  [self.itemsTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
