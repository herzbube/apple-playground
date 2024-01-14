//
//  ViewController.m
//  boardpositioncollectionviewcell-layout
//
//  Created by Patrick Näf Moser on 14.01.2024.
//

#import "ViewController.h"
#import "BoardPositionCollectionViewCell.h"
#import "AutoLayoutUtility.h"

@interface ViewController()
@property (weak, nonatomic) IBOutlet UIView* inputContainerView;
@property (weak, nonatomic) IBOutlet UIView* boardPositionCellViewContainerView;
@property (strong, nonatomic) BoardPositionCellView* boardPositionCellView;
@property (weak, nonatomic) IBOutlet UITextField* textTextField;
@property (weak, nonatomic) IBOutlet UITextField* detailTextTextField;
@property (weak, nonatomic) IBOutlet UITextField* capturedStonesTextField;
@property (weak, nonatomic) IBOutlet UISwitch* showBackgroundColorsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch* showDetailsTextLabelSwitch;
@property (weak, nonatomic) IBOutlet UISwitch* showCapturedStonesLabelSwitch;
@property (weak, nonatomic) IBOutlet UISwitch* showHotspotIconSwitch;
@property (weak, nonatomic) IBOutlet UISwitch* showInfoIconSwitch;
@property (weak, nonatomic) IBOutlet UISwitch* showMarkupIconSwitch;
@property (weak, nonatomic) IBOutlet UISwitch* activateEqualHeightsConstraintSwitch;
@property (weak, nonatomic) IBOutlet UISwitch* useHiddenPropertySwitch;
@property (weak, nonatomic) IBOutlet UISwitch* activateContentSizeConstraintsSwitch;
@property (weak, nonatomic) IBOutlet UITextField* contentWidthTextField;
@property (weak, nonatomic) IBOutlet UITextField* contentHeightTextField;
@end

@interface ViewController ()

@end

@implementation ViewController

- (void) viewDidLoad
{
  [super viewDidLoad];

  self.boardPositionCellView = [[BoardPositionCellView alloc] initWithFrame:CGRectZero];
  [self.boardPositionCellViewContainerView addSubview:self.boardPositionCellView];
  self.boardPositionCellView.translatesAutoresizingMaskIntoConstraints = NO;
  [AutoLayoutUtility fillSuperview:self.boardPositionCellViewContainerView withSubview:self.boardPositionCellView];

  self.textTextField.text = self.boardPositionCellView.text;
  self.detailTextTextField.text = self.boardPositionCellView.detailText;
  self.capturedStonesTextField.text = self.boardPositionCellView.capturedStones;

  self.showBackgroundColorsSwitch.on = self.boardPositionCellView.useBackgroundColors;
  self.showDetailsTextLabelSwitch.on = self.boardPositionCellView.showDetailText;
  self.showCapturedStonesLabelSwitch.on = self.boardPositionCellView.showCapturedStones;
  self.showHotspotIconSwitch.on = self.boardPositionCellView.showHotspotIcon;
  self.showInfoIconSwitch.on = self.boardPositionCellView.showInfoIcon;
  self.showMarkupIconSwitch.on = self.boardPositionCellView.showMarkupIcon;

  self.activateEqualHeightsConstraintSwitch.on = self.boardPositionCellView.activateEqualHeightsConstraint;
  self.useHiddenPropertySwitch.on = self.boardPositionCellView.useHiddenProperty;

  self.activateContentSizeConstraintsSwitch.on = self.boardPositionCellView.activateContentSizeConstraints;
  self.contentWidthTextField.text = [NSString stringWithFormat:@"%f", self.boardPositionCellView.contentSize.width];
  self.contentHeightTextField.text = [NSString stringWithFormat:@"%f", self.boardPositionCellView.contentSize.height];
}

#pragma mark - Text field input actions

- (IBAction) textEditingDidEnd:(UITextField*)sender
{
  self.boardPositionCellView.text = sender.text;
}

- (IBAction) detailTextEditingDidEnd:(UITextField*)sender
{
  self.boardPositionCellView.detailText = sender.text;
}

- (IBAction) capturedStonesEditingDidEnd:(UITextField*)sender
{
  self.boardPositionCellView.capturedStones = sender.text;
}

- (IBAction) contentWidthEditingDidEnd:(UITextField*)sender
{
  CGSize newContentSize = CGSizeMake([sender.text floatValue],
                                     self.boardPositionCellView.contentSize.height);
  self.boardPositionCellView.contentSize = newContentSize;
}

- (IBAction) contentHeightEditingDidEnd:(UITextField*)sender
{
  CGSize newContentSize = CGSizeMake(self.boardPositionCellView.contentSize.width,
                                     [sender.text floatValue]);
  self.boardPositionCellView.contentSize = newContentSize;
}

#pragma mark - Switch input actions

- (IBAction) showBackgroundColorsValueChanged:(UISwitch*)sender
{
  self.boardPositionCellView.useBackgroundColors = sender.on;
}

- (IBAction) showDetailTextLabelValueChanged:(UISwitch*)sender
{
  self.boardPositionCellView.showDetailText = sender.on;
}

- (IBAction) showCapturedStonesLabelValueChanged:(UISwitch*)sender
{
  self.boardPositionCellView.showCapturedStones = sender.on;
}

- (IBAction) showHotspotIconValueChanged:(UISwitch*)sender
{
  self.boardPositionCellView.showHotspotIcon = sender.on;
}

- (IBAction) showInfoIconValueChanged:(UISwitch*)sender
{
  self.boardPositionCellView.showInfoIcon = sender.on;
}

- (IBAction) showMarkupIconValueChanged:(UISwitch*)sender
{
  self.boardPositionCellView.showMarkupIcon = sender.on;
}

- (IBAction) activateEqualHeightsConstraintChanged:(UISwitch*)sender
{
  self.boardPositionCellView.activateEqualHeightsConstraint = sender.on;
}

- (IBAction) useHiddenPropertyChanged:(UISwitch*)sender
{
  self.boardPositionCellView.useHiddenProperty = sender.on;
}

- (IBAction) activateContentSizeConstraintsChanged:(UISwitch*)sender
{
  self.boardPositionCellView.activateContentSizeConstraints = sender.on;
}

@end
