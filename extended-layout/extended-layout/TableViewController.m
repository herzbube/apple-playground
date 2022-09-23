//
//  TableViewController.m
//  extended-layout
//
//  Created by Patrick Näf Moser on 05.03.22.
//

#import "TableViewController.h"
#import "AppDelegate.h"

enum TableViewSection
{
  PlaceholderTopSection,
  EdgesForExtendedLayoutSection,
  ScrollViewInsetsSection,
  OpaqueBarSection,
  BackgroundColorSection,
  PlaceholderBottomSection,
  MaxSection
};

enum PlaceholderTopSectionItem
{
  Placeholder1TableViewCellItem,
  Placeholder2TableViewCellItem,
  MaxPlaceholderTopSectionItem
};

enum EdgesForExtendedLayoutSectionItem
{
  UIRectEdgeAllTableViewCellItem,
  UIRectEdgeNoneTableViewCellItem,
  UIRectEdgeTopTableViewCellItem,
  UIRectEdgeBottomTableViewCellItem,
  MaxEdgesForExtendedLayoutSectionItem
};

enum ScrollViewInsetsSectionItem
{
  AutomaticallyAdjustsScrollViewInsetsTableViewCellItem,
  UIScrollViewContentInsetAdjustmentAutomaticTableViewCellItem,
  UIScrollViewContentInsetAdjustmentScrollableAxesTableViewCellItem,
  UIScrollViewContentInsetAdjustmentNeverTableViewCellItem,
  UIScrollViewContentInsetAdjustmentAlwaysTableViewCellItem,
  MaxScrollViewInsetsSectionItem
};

enum OpaqueBarSectionItem
{
  ExtendedLayoutIncludesOpaqueBarsTableViewCellItem,
  TranslucentNavigationBarTableViewCellItem,
  TranslucentTabBarTableViewCellItem,
  MaxOpaqueBarSectionItem
};

enum BackgroundColorSectionItem
{
  CustomTableViewBackgroundColorTableViewCellItem,
  CustomNavigationControllerViewBackgroundColorTableViewCellItem,
  CustomTabBarControllerViewBackgroundColorTableViewCellItem,
  CustomWindowBackgroundColorTableViewCellItem,
  CustomNavigationBarBackgroundColorTableViewCellItem,
  CustomTabBarBackgroundColorTableViewCellItem,
  DefaultIosBackgroundColorsTableViewCellItem,
  MaxBackgroundColorSectionItem
};

enum PlaceholderBottomSectionItem
{
  Placeholder3TableViewCellItem,
  Placeholder4TableViewCellItem,
  MaxPlaceholderBottomSectionItem
};


@interface TableViewController ()
@property bool useSmallFonts;
@end

@implementation TableViewController


- (void) viewDidLoad
{
  [super viewDidLoad];
  self.title = @"Navigation bar - Table view controller";
  CGSize screenSize = [UIScreen mainScreen].bounds.size;
  CGFloat smallerDimension = MIN(screenSize.width, screenSize.height);
  self.useSmallFonts = (smallerDimension < 400);
}

#pragma mark - UITableViewDataSource overrides

// -----------------------------------------------------------------------------
/// @brief UITableViewDataSource protocol method.
// -----------------------------------------------------------------------------
- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView
{
  return MaxSection;
}

// -----------------------------------------------------------------------------
/// @brief UITableViewDataSource protocol method.
// -----------------------------------------------------------------------------
- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
  switch (section)
  {
    case PlaceholderTopSection:
      return MaxPlaceholderTopSectionItem;
    case EdgesForExtendedLayoutSection:
      return MaxEdgesForExtendedLayoutSectionItem;
    case ScrollViewInsetsSection:
      return MaxScrollViewInsetsSectionItem;
    case OpaqueBarSection:
      return MaxOpaqueBarSectionItem;
    case BackgroundColorSection:
      return MaxBackgroundColorSectionItem;
    case PlaceholderBottomSection:
      return MaxPlaceholderBottomSectionItem;
    default:
      break;
  }
  return 0;
}

// -----------------------------------------------------------------------------
/// @brief UITableViewDataSource protocol method.
// -----------------------------------------------------------------------------
- (NSString*) tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
  switch (section)
  {
    case PlaceholderTopSection:
      return @"Placeholders Top";
    case EdgesForExtendedLayoutSection:
      return @"Property edgesForExtendedLayout";
    case ScrollViewInsetsSection:
      return @"ScrollView insets";
    case OpaqueBarSection:
      return @"Opaque bars";
    case BackgroundColorSection:
      return @"Background colors";
    case PlaceholderBottomSection:
      return @"Placeholders Bottom";
    default:
      break;
  }
  return nil;
}

// -----------------------------------------------------------------------------
/// @brief UITableViewDataSource protocol method.
// -----------------------------------------------------------------------------
- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
  UITableViewCell* cell = nil;

  cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                reuseIdentifier:@"SubtitleCell"];

  if (self.useSmallFonts)
  {
    cell.textLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize] * 0.8];
  }

  cell.accessoryType = UITableViewCellAccessoryNone;

  AppDelegate* appDelegate = [AppDelegate sharedAppDelegate];

  switch (indexPath.section)
  {
    case PlaceholderTopSection:
      switch (indexPath.row)
      {
        case Placeholder1TableViewCellItem:
          cell.textLabel.text = @"Placeholder 1";
          cell.detailTextLabel.text = @"Tapping has no effect";
          break;
        case Placeholder2TableViewCellItem:
          cell.textLabel.text = @"Placeholder 2";
          cell.detailTextLabel.text = @"Tapping has no effect";
          break;
        default:
          break;
      }
      break;
    case EdgesForExtendedLayoutSection:
      switch (indexPath.row)
      {
        case UIRectEdgeAllTableViewCellItem:
          cell.textLabel.text = @"edgesForExtendedLayout (VC)";
          cell.detailTextLabel.text = @"Tap to set UIRectEdgeAll";
          if (self.edgesForExtendedLayout == UIRectEdgeAll)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
          break;
        case UIRectEdgeNoneTableViewCellItem:
          cell.textLabel.text = @"edgesForExtendedLayout (VC)";
          cell.detailTextLabel.text = @"Tap to set UIRectEdgeNone";
          if (self.edgesForExtendedLayout == UIRectEdgeNone)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
          break;
        case UIRectEdgeTopTableViewCellItem:
          cell.textLabel.text = @"edgesForExtendedLayout (VC)";
          cell.detailTextLabel.text = @"Tap to set UIRectEdgeTop";
          if (self.edgesForExtendedLayout == UIRectEdgeTop)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
          break;
        case UIRectEdgeBottomTableViewCellItem:
          cell.textLabel.text = @"edgesForExtendedLayout (VC)";
          cell.detailTextLabel.text = @"Tap to set UIRectEdgeBottom";
          if (self.edgesForExtendedLayout == UIRectEdgeBottom)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
          break;
        default:
          break;
      }
      break;
    case ScrollViewInsetsSection:
      switch (indexPath.row)
      {
        case AutomaticallyAdjustsScrollViewInsetsTableViewCellItem:
          cell.textLabel.text = @"automaticallyAdjustsScrollViewInsets (VC)";
          cell.detailTextLabel.text = @"Tap to toggle";
          if (self.automaticallyAdjustsScrollViewInsets == YES)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
          break;
        case UIScrollViewContentInsetAdjustmentAutomaticTableViewCellItem:
          cell.textLabel.text = @"contentInsetAdjustmentBehavior (scroll view)";
          cell.detailTextLabel.text = @"Tap to set UIScrollViewContentInsetAdjustmentAutomatic";
          if (self.tableView.contentInsetAdjustmentBehavior == UIScrollViewContentInsetAdjustmentAutomatic)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
          break;
        case UIScrollViewContentInsetAdjustmentScrollableAxesTableViewCellItem:
          cell.textLabel.text = @"contentInsetAdjustmentBehavior (scroll view)";
          cell.detailTextLabel.text = @"Tap to set UIScrollViewContentInsetAdjustmentScrollableAxes";
          if (self.tableView.contentInsetAdjustmentBehavior == UIScrollViewContentInsetAdjustmentScrollableAxes)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
          break;
        case UIScrollViewContentInsetAdjustmentNeverTableViewCellItem:
          cell.textLabel.text = @"contentInsetAdjustmentBehavior (scroll view)";
          cell.detailTextLabel.text = @"Tap to set UIScrollViewContentInsetAdjustmentNever";
          if (self.tableView.contentInsetAdjustmentBehavior == UIScrollViewContentInsetAdjustmentNever)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
          break;
        case UIScrollViewContentInsetAdjustmentAlwaysTableViewCellItem:
          cell.textLabel.text = @"contentInsetAdjustmentBehavior (scroll view)";
          cell.detailTextLabel.text = @"Tap to set UIScrollViewContentInsetAdjustmentAlways";
          if (self.tableView.contentInsetAdjustmentBehavior == UIScrollViewContentInsetAdjustmentAlways)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
          break;
        default:
          break;
      }
      break;
    case OpaqueBarSection:
      switch (indexPath.row)
      {
        case ExtendedLayoutIncludesOpaqueBarsTableViewCellItem:
          cell.textLabel.text = @"extendedLayoutIncludesOpaqueBars (VC)";
          cell.detailTextLabel.text = @"Tap to toggle";
          if (self.extendedLayoutIncludesOpaqueBars == YES)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
          break;
        case TranslucentNavigationBarTableViewCellItem:
          cell.textLabel.text = @"translucent (navigation bar)";
          cell.detailTextLabel.text = @"Tap to toggle";
          if (self.navigationController.navigationBar.translucent == YES)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
          break;
        case TranslucentTabBarTableViewCellItem:
          cell.textLabel.text = @"translucent (tab bar)";
          cell.detailTextLabel.text = @"Tap to toggle";
          if (self.tabBarController.tabBar.translucent == YES)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
          break;
        default:
          break;
      }
      break;
    case BackgroundColorSection:
      switch (indexPath.row)
      {
        case CustomTableViewBackgroundColorTableViewCellItem:
          cell.textLabel.text = @"Custom Table VC view background color (green)";
          cell.detailTextLabel.text = @"Tap to toggle";
          if (self.view.backgroundColor == appDelegate.customTableViewControllerViewBackgroundColor)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
          break;
        case CustomNavigationControllerViewBackgroundColorTableViewCellItem:
          cell.textLabel.text = @"Custom Nav. VC view background color (yellow)";
          cell.detailTextLabel.text = @"Tap to toggle";
          if (self.navigationController.view.backgroundColor == appDelegate.customNavigationControllerViewBackgroundColor)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
          break;
        case CustomTabBarControllerViewBackgroundColorTableViewCellItem:
          cell.textLabel.text = @"Custom Tab bar VC view background color (blue)";
          cell.detailTextLabel.text = @"Tap to toggle";
          if (self.tabBarController.view.backgroundColor == appDelegate.customTabBarControllerViewBackgroundColor)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
          break;
        case CustomWindowBackgroundColorTableViewCellItem:
          cell.textLabel.text = @"Custom Window background color (red)";
          cell.detailTextLabel.text = @"Tap to toggle";
          if (self.view.window.backgroundColor == appDelegate.customWindowBackgroundColor)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
          break;
        case CustomNavigationBarBackgroundColorTableViewCellItem:
          cell.textLabel.text = @"Custom Navigation bar background color (purple)";
          cell.detailTextLabel.text = @"Tap to toggle";
          if (self.navigationController.navigationBar.backgroundColor == appDelegate.customNavigationBarBackgroundColor)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
          break;
        case CustomTabBarBackgroundColorTableViewCellItem:
          cell.textLabel.text = @"Custom Tab bar background color (cyan)";
          cell.detailTextLabel.text = @"Tap to toggle";
          if (self.tabBarController.tabBar.backgroundColor == appDelegate.customTabBarBackgroundColor)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
          break;
        case DefaultIosBackgroundColorsTableViewCellItem:
          cell.textLabel.text = @"Default iOS colors";
          cell.detailTextLabel.text = @"Tap to toggle";
          if (self.viewsHaveDefaultIosBackgroundColors)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
          break;
        default:
          break;
      }
      break;
    case PlaceholderBottomSection:
      switch (indexPath.row)
      {
        case Placeholder3TableViewCellItem:
          cell.textLabel.text = @"Placeholder 3";
          cell.detailTextLabel.text = @"Tapping has no effect";
          break;
        case Placeholder4TableViewCellItem:
          cell.textLabel.text = @"Placeholder 4";
          cell.detailTextLabel.text = @"Tapping has no effect";
          break;
        default:
          break;
      }
      break;
    default:
      cell.textLabel.text = @"???";
      cell.detailTextLabel.text = @"???";
      break;
  }

  return cell;
}

#pragma mark - UITableViewDelegate overrides

// -----------------------------------------------------------------------------
/// @brief UITableViewDelegate protocol method.
// -----------------------------------------------------------------------------
- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:NO];

  AppDelegate* appDelegate = [AppDelegate sharedAppDelegate];

  switch (indexPath.section)
  {
    case PlaceholderTopSection:
      switch (indexPath.row)
      {
        case Placeholder1TableViewCellItem:
        case Placeholder2TableViewCellItem:
          return;
        default:
          break;
      }
      break;
    case EdgesForExtendedLayoutSection:
      switch (indexPath.row)
      {
        case UIRectEdgeAllTableViewCellItem:
          self.edgesForExtendedLayout = UIRectEdgeAll;
          break;
        case UIRectEdgeNoneTableViewCellItem:
          self.edgesForExtendedLayout = UIRectEdgeNone;
          break;
        case UIRectEdgeTopTableViewCellItem:
          self.edgesForExtendedLayout = UIRectEdgeTop;
          break;
        case UIRectEdgeBottomTableViewCellItem:
          self.edgesForExtendedLayout = UIRectEdgeBottom;
          break;
        default:
          break;
      }
      // See method documentation why we do this
      [appDelegate updateBarsInViewController:self.navigationController bySwitchingTabInTabBarController:self.tabBarController];
      break;
    case ScrollViewInsetsSection:
      switch (indexPath.row)
      {
        case AutomaticallyAdjustsScrollViewInsetsTableViewCellItem:
          if (self.automaticallyAdjustsScrollViewInsets == YES)
            self.automaticallyAdjustsScrollViewInsets = NO;
          else
            self.automaticallyAdjustsScrollViewInsets = YES;
          break;
        case UIScrollViewContentInsetAdjustmentAutomaticTableViewCellItem:
          self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
          break;
        case UIScrollViewContentInsetAdjustmentScrollableAxesTableViewCellItem:
          self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentScrollableAxes;
          break;
        case UIScrollViewContentInsetAdjustmentNeverTableViewCellItem:
          self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
          break;
        case UIScrollViewContentInsetAdjustmentAlwaysTableViewCellItem:
          self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
          break;
        default:
          break;
      }
      break;
    case OpaqueBarSection:
      switch (indexPath.row)
      {
        case ExtendedLayoutIncludesOpaqueBarsTableViewCellItem:
          if (self.extendedLayoutIncludesOpaqueBars == YES)
            self.extendedLayoutIncludesOpaqueBars = NO;
          else
            self.extendedLayoutIncludesOpaqueBars = YES;
          break;
        case TranslucentNavigationBarTableViewCellItem:
          if (self.navigationController.navigationBar.translucent == YES)
            self.navigationController.navigationBar.translucent = NO;
          else
            self.navigationController.navigationBar.translucent = YES;
          break;
        case TranslucentTabBarTableViewCellItem:
          if (self.tabBarController.tabBar.translucent == YES)
            self.tabBarController.tabBar.translucent = NO;
          else
            self.tabBarController.tabBar.translucent = YES;
          break;
        default:
          break;
      }
      break;
    case BackgroundColorSection:
      switch (indexPath.row)
      {
        case CustomTableViewBackgroundColorTableViewCellItem:
          if (self.view.backgroundColor == appDelegate.customTableViewControllerViewBackgroundColor)
            self.view.backgroundColor = appDelegate.defaultTableViewControllerViewBackgroundColor;
          else
            self.view.backgroundColor = appDelegate.customTableViewControllerViewBackgroundColor;
          break;
        case CustomNavigationControllerViewBackgroundColorTableViewCellItem:
          if (self.navigationController.view.backgroundColor == appDelegate.customNavigationControllerViewBackgroundColor)
            self.navigationController.view.backgroundColor = appDelegate.defaultNavigationControllerViewBackgroundColor;
          else
            self.navigationController.view.backgroundColor = appDelegate.customNavigationControllerViewBackgroundColor;
          break;
        case CustomTabBarControllerViewBackgroundColorTableViewCellItem:
          if (self.tabBarController.view.backgroundColor == appDelegate.customTabBarControllerViewBackgroundColor)
            self.tabBarController.view.backgroundColor = appDelegate.defaultTabBarControllerViewBackgroundColor;
          else
            self.tabBarController.view.backgroundColor = appDelegate.customTabBarControllerViewBackgroundColor;
          break;
        case CustomWindowBackgroundColorTableViewCellItem:
          if (self.view.window.backgroundColor == appDelegate.customWindowBackgroundColor)
            self.view.window.backgroundColor = appDelegate.defaultWindowBackgroundColor;
          else
            self.view.window.backgroundColor = appDelegate.customWindowBackgroundColor;
          break;
        case CustomNavigationBarBackgroundColorTableViewCellItem:
          if (self.navigationController.navigationBar.backgroundColor == appDelegate.customNavigationBarBackgroundColor)
            self.navigationController.navigationBar.backgroundColor = appDelegate.defaultNavigationBarBackgroundColor;
          else
            self.navigationController.navigationBar.backgroundColor = appDelegate.customNavigationBarBackgroundColor;
          break;
        case CustomTabBarBackgroundColorTableViewCellItem:
          if (self.tabBarController.tabBar.backgroundColor == appDelegate.customTabBarBackgroundColor)
            self.tabBarController.tabBar.backgroundColor = appDelegate.defaultTabBarBackgroundColor;
          else
            self.tabBarController.tabBar.backgroundColor = appDelegate.customTabBarBackgroundColor;
          break;
        case DefaultIosBackgroundColorsTableViewCellItem:
          if (self.viewsHaveDefaultIosBackgroundColors)
            [self applyCustomBackgroundColors];
          else
            [self applyDefaultIosBackgroundColors];
          break;
        default:
          break;
      }
      break;
    case PlaceholderBottomSection:
      switch (indexPath.row)
      {
        case Placeholder3TableViewCellItem:
        case Placeholder4TableViewCellItem:
          return;
        default:
          break;
      }
      break;
    default:
      break;
  }

  [self.tableView reloadData];
}

- (bool) viewsHaveDefaultIosBackgroundColors
{
  AppDelegate* appDelegate = [AppDelegate sharedAppDelegate];

  if (self.view.window.backgroundColor == appDelegate.defaultWindowBackgroundColor &&
      self.tabBarController.view.backgroundColor == appDelegate.defaultTabBarControllerViewBackgroundColor &&
      self.navigationController.view.backgroundColor == appDelegate.defaultNavigationControllerViewBackgroundColor &&
      self.view.backgroundColor == appDelegate.defaultTableViewControllerViewBackgroundColor &&
      self.navigationController.navigationBar.backgroundColor == appDelegate.defaultNavigationBarBackgroundColor &&
      self.tabBarController.tabBar.backgroundColor == appDelegate.defaultTabBarBackgroundColor)
  {
    return true;
  }
  else
  {
    return false;
  }
}

- (void) applyCustomBackgroundColors
{
  AppDelegate* appDelegate = [AppDelegate sharedAppDelegate];

  self.view.window.backgroundColor = appDelegate.customWindowBackgroundColor;
  self.tabBarController.view.backgroundColor = appDelegate.customTabBarControllerViewBackgroundColor;
  self.navigationController.view.backgroundColor = appDelegate.customNavigationControllerViewBackgroundColor;
  self.view.backgroundColor = appDelegate.customTableViewControllerViewBackgroundColor;

  // Don't apply custom colors to bars
}

- (void) applyDefaultIosBackgroundColors
{
  AppDelegate* appDelegate = [AppDelegate sharedAppDelegate];

  self.view.window.backgroundColor = appDelegate.defaultWindowBackgroundColor;
  self.tabBarController.view.backgroundColor = appDelegate.defaultTabBarControllerViewBackgroundColor;
  self.navigationController.view.backgroundColor = appDelegate.defaultNavigationControllerViewBackgroundColor;
  self.view.backgroundColor = appDelegate.defaultTableViewControllerViewBackgroundColor;
  self.navigationController.navigationBar.backgroundColor = appDelegate.defaultNavigationBarBackgroundColor;
  self.tabBarController.tabBar.backgroundColor = appDelegate.defaultTabBarBackgroundColor;
}

@end
