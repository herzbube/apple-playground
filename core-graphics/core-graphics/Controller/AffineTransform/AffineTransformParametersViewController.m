//
//  AffineTransformParametersViewController.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 25.03.23.
//

#import "AffineTransformParametersViewController.h"
#import "AffineTransformParametersItemViewController.h"
#import "../../Model/AffineTransform/AffineTransformParameters.h"
#import "../../Model/AffineTransform/AffineTransformParametersItem.h"
#import "../../AutoLayoutUtility.h"
#import "../../Converter.h"

static NSString* reusableCellIdentifier = @"AffineTransformParametersItem";

@interface AffineTransformParametersViewController()
@property (weak, nonatomic) IBOutlet UISwitch* affineTransformEnabledSwitch;
@property (weak, nonatomic) IBOutlet UIStackView* topLevelStackView;
// Strong reference is needed so that the object is not deallocated when it is
// removed from the view hierarchy
@property (strong, nonatomic) IBOutlet UIStackView* masterDetailStackView;
@property (weak, nonatomic) IBOutlet UITableView* transformsTableView;
@property (weak, nonatomic) IBOutlet UIView* detailContainerView;
@property (strong, nonatomic) IBOutlet UITextField* concatenatedAffineTransformTextField;
@property (nonatomic) NSUInteger indexOfSelectedAffineTransformParametersItem;
@property (strong, nonatomic) AffineTransformParametersItem* selectedAffineTransformParametersItem;
@end

@implementation AffineTransformParametersViewController

#pragma mark - Initialization, deallocation

- (instancetype) initWithAffineTransformParameters:(AffineTransformParameters*)affineTransformParameters
{
  self = [super initWithNibName:@"AffineTransformParametersViewController" bundle:nil];
  if (! self)
    return nil;

  if (affineTransformParameters)
    self.affineTransformParameters = affineTransformParameters;
  else
    self.affineTransformParameters = [[AffineTransformParameters alloc] init];

  return self;
}

#pragma mark - UIViewController methods

- (void) viewDidLoad
{
  [super viewDidLoad];

  [self startObserving];
  
  [self integrateChildViewControllers];
  [self updateUiWithModelValues];
}

#pragma mark - Manage child view controllers

- (void) integrateChildViewControllers
{
  AffineTransformParametersItemViewController* affineTransformParametersItemViewController = [[AffineTransformParametersItemViewController alloc] init];

  [self addChildViewController:affineTransformParametersItemViewController];
  [affineTransformParametersItemViewController didMoveToParentViewController:self];

  UIView* affineTransformParametersItemView = affineTransformParametersItemViewController.view;
  [self.detailContainerView addSubview:affineTransformParametersItemView];
  affineTransformParametersItemView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.detailContainerView withSubview:affineTransformParametersItemView];
}

#pragma mark - Switch input actions

- (IBAction) affineTransformEnabledValueChanged:(UISwitch*)sender
{
  BOOL affineTransformEnabled = sender.on;

  self.affineTransformParameters.affineTransformEnabled = affineTransformEnabled;

  [self updateUiVisibility];
}

#pragma mark - Button interactions

- (IBAction) addButtonTapped:(UIButton*)sender
{
  NSUInteger insertPosition = self.indexOfSelectedAffineTransformParametersItem + 1;
  NSUInteger indexOfInsertedItem = [self.affineTransformParameters insertItemAt:insertPosition];

  [self.transformsTableView reloadData];

  [self updateSelectedAffineTransformParametersItem:indexOfInsertedItem];
  [self updateCellSelection];
  [self updateDetailsView];
}

- (IBAction) removeButtonTapped:(UIButton*)sender
{
  NSUInteger indexOfItemToRemove = self.indexOfSelectedAffineTransformParametersItem;
  bool success = [self.affineTransformParameters removeItemAt:indexOfItemToRemove];
  if (! success)
    return;

  [self.transformsTableView reloadData];

  NSUInteger numberOfItemsAfterRemoval = self.affineTransformParameters.affineTransformParametersItems.count;
  NSUInteger indexOfNewlySelectedItem = (indexOfItemToRemove < numberOfItemsAfterRemoval
                                         ? indexOfItemToRemove
                                         : numberOfItemsAfterRemoval - 1);
  [self updateSelectedAffineTransformParametersItem:indexOfNewlySelectedItem];
  [self updateCellSelection];
  [self updateDetailsView];
}

- (IBAction) moveUpButtonTapped:(UIButton*)sender
{
  NSUInteger indexOfItemToMoveUp = self.indexOfSelectedAffineTransformParametersItem;
  bool success = [self.affineTransformParameters moveUpItemAt:indexOfItemToMoveUp];
  if (! success)
    return;

  [self.transformsTableView reloadData];

  NSUInteger indexOfNewlySelectedItem = indexOfItemToMoveUp - 1;
  [self updateSelectedAffineTransformParametersItem:indexOfNewlySelectedItem];
  [self updateCellSelection];
}

- (IBAction) moveDownButtonTapped:(UIButton*)sender
{
  NSUInteger indexOfItemToMoveDown = self.indexOfSelectedAffineTransformParametersItem;
  bool success = [self.affineTransformParameters moveDownItemAt:indexOfItemToMoveDown];
  if (! success)
    return;

  [self.transformsTableView reloadData];

  NSUInteger indexOfNewlySelectedItem = indexOfItemToMoveDown + 1;
  [self updateSelectedAffineTransformParametersItem:indexOfNewlySelectedItem];
  [self updateCellSelection];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView
{
  return 1;
}

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.affineTransformParameters.affineTransformParametersItems.count;
}

- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
  AffineTransformParametersItem* affineTransformParametersItem = [self affineTransformParametersItemAtIndex:indexPath.row];
  if (! affineTransformParametersItem)
    return nil;

  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reusableCellIdentifier];
  if (! cell)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:reusableCellIdentifier];
  }

  cell.textLabel.text = [affineTransformParametersItem affineTransformTypeAsString];
  cell.detailTextLabel.text = [affineTransformParametersItem parametersAsString];

  return cell;
}

#pragma mark - UITableViewDelegate methods

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
  [self updateSelectedAffineTransformParametersItem:indexPath.row];
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
  self.affineTransformEnabledSwitch.on = self.affineTransformParameters.affineTransformEnabled;
  self.concatenatedAffineTransformTextField.text = self.affineTransformParameters.affineTransformAsString;

  [self updateUiVisibility];

  [self.transformsTableView reloadData];

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
  NSUInteger indexOfItem = (self.affineTransformParameters.affineTransformParametersItems.count > 0
                            ? 0
                            : -1);
  [self updateSelectedAffineTransformParametersItem:indexOfItem];
  [self updateCellSelection];
  [self updateDetailsView];
}

- (void) updateUiVisibility
{
  if (self.affineTransformParameters.affineTransformEnabled)
  {
    if (! [self.topLevelStackView.arrangedSubviews containsObject:self.masterDetailStackView])
      [self.topLevelStackView insertArrangedSubview:self.masterDetailStackView atIndex:0];
  }
  else
  {
    if ([self.topLevelStackView.arrangedSubviews containsObject:self.masterDetailStackView])
    {
      [self.topLevelStackView removeArrangedSubview:self.masterDetailStackView];
      [self.masterDetailStackView removeFromSuperview];
    }
  }
}

- (void) updateSelectedAffineTransformParametersItem:(NSUInteger)indexOfAffineTransformParametersItem
{
  // Don't try to optimize by comparing the old/new index - when removing an
  // item the old/new index could be the same, but the old/new item is not

  if (self.selectedAffineTransformParametersItem)
    [self stopObservingAffineTransformParametersItem:self.selectedAffineTransformParametersItem];

  self.indexOfSelectedAffineTransformParametersItem = indexOfAffineTransformParametersItem;
  self.selectedAffineTransformParametersItem = [self affineTransformParametersItemAtIndex:self.indexOfSelectedAffineTransformParametersItem];

  if (self.selectedAffineTransformParametersItem)
    [self startObservingAffineTransformParametersItem:self.selectedAffineTransformParametersItem];
}

- (AffineTransformParametersItem*) affineTransformParametersItemAtIndex:(NSUInteger)indexOfAffineTransformParametersItem
{
  NSArray* affineTransformParametersItems = self.affineTransformParameters.affineTransformParametersItems;
  if (indexOfAffineTransformParametersItem < affineTransformParametersItems.count)
    return [affineTransformParametersItems objectAtIndex:indexOfAffineTransformParametersItem];
  else
    return nil;
}

- (void) updateCellSelection
{
  if (self.indexOfSelectedAffineTransformParametersItem == -1)
    return;

  NSIndexPath* indexPath = [NSIndexPath indexPathForRow:self.indexOfSelectedAffineTransformParametersItem
                                              inSection:0];

  // The table view does ***not*** invoke tableView:didSelectRowAtIndexPath: on
  // the delegate => the caller must also invoke updateDetailsView
  [self.transformsTableView selectRowAtIndexPath:indexPath
                                        animated:YES
                                  scrollPosition:UITableViewScrollPositionMiddle];
}

- (void) updateDetailsView
{
  AffineTransformParametersItem* affineTransformParametersItem = [self affineTransformParametersItemAtIndex:self.indexOfSelectedAffineTransformParametersItem];

  AffineTransformParametersItemViewController* affineTransformParametersItemViewController = self.childViewControllers.firstObject;
  [affineTransformParametersItemViewController updateAffineTransformParametersItem:affineTransformParametersItem];
}

#pragma mark - KVO

- (void) startObserving
{
  [self.affineTransformParameters addObserver:self forKeyPath:@"affineTransformAsString" options:0 context:NULL];
}

- (void) startObservingAffineTransformParametersItem:(AffineTransformParametersItem*)affineTransformParametersItem
{
  [affineTransformParametersItem addObserver:self forKeyPath:@"affineTransformTypeAsString" options:0 context:NULL];
  [affineTransformParametersItem addObserver:self forKeyPath:@"parametersAsString" options:0 context:NULL];
}

- (void) stopObservingAffineTransformParametersItem:(AffineTransformParametersItem*)affineTransformParametersItem
{
  [affineTransformParametersItem removeObserver:self forKeyPath:@"affineTransformTypeAsString"];
  [affineTransformParametersItem removeObserver:self forKeyPath:@"parametersAsString"];
}

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
  if (object == self.affineTransformParameters)
  {
    self.concatenatedAffineTransformTextField.text = self.affineTransformParameters.affineTransformAsString;
  }
  else
  {
    NSUInteger indexOfAffineTransformParametersItem = [self.affineTransformParameters.affineTransformParametersItems indexOfObject:object];
    if (indexOfAffineTransformParametersItem == NSNotFound)
      return;

    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:indexOfAffineTransformParametersItem
                                                inSection:0];
    [self.transformsTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
  }
}

@end
