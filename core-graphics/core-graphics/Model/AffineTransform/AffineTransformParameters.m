//
//  AffineTransformParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 25.03.23.
//

#import "AffineTransformParameters.h"
#import "AffineTransformParametersItem.h"

static NSString* affineTransformEnabledKey = @"affineTransformEnabled";
static NSString* affineTransformParametersItemsKey = @"affineTransformParametersItems";

@implementation AffineTransformParameters

- (instancetype) init
{
  self = [super init];

  self.affineTransformParametersItems = [NSMutableArray array];
  [self initializeWithDefaultValues];

  return self;
}

- (void) initializeWithDefaultValues
{
  self.affineTransformEnabled = true;
  [self removeAllItems];

  [self updateParametersDidChange];
}

- (NSDictionary*) valuesAsDictionary
{
  NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];

  dictionary[affineTransformEnabledKey] = @(self.affineTransformEnabled);

  NSMutableArray* itemValuesDictionaries = [NSMutableArray array];
  for (AffineTransformParametersItem* item in self.affineTransformParametersItems)
    [itemValuesDictionaries addObject:[item valuesAsDictionary]];
  dictionary[affineTransformParametersItemsKey] = itemValuesDictionaries;

  return dictionary;
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  self.affineTransformEnabled = [dictionary[affineTransformEnabledKey] floatValue];

  [self removeAllItems];

  NSMutableArray* itemValuesDictionaries = dictionary[affineTransformParametersItemsKey];
  for (NSDictionary* itemValuesDictionary in itemValuesDictionaries)
  {
    AffineTransformParametersItem* item = [[AffineTransformParametersItem alloc] init];
    [item setValuesWithDictionary:itemValuesDictionary];

    [self startObservingAffineTransformParametersItem:item];
    [self.affineTransformParametersItems addObject:item];
  }

  [self updateParametersDidChange];
}

- (void) resetToDefaultValues
{
  [self initializeWithDefaultValues];
}

#pragma mark - Manage items - Public API

- (NSUInteger) insertItemAt:(NSUInteger)index
{
  AffineTransformParametersItem* item = [[AffineTransformParametersItem alloc] init];
  [self startObservingAffineTransformParametersItem:item];

  NSUInteger indexOfNewItem;
  NSUInteger numberOfItems = self.affineTransformParametersItems.count;
  if (index < numberOfItems)
  {
    [self.affineTransformParametersItems insertObject:item atIndex:index];
    indexOfNewItem = index;
  }
  else
  {
    [self.affineTransformParametersItems addObject:item];
    indexOfNewItem = self.affineTransformParametersItems.count - 1;
  }

  [self updateParametersDidChange];

  return indexOfNewItem;
}

- (bool) removeItemAt:(NSUInteger)index
{
  NSUInteger numberOfItems = self.affineTransformParametersItems.count;
  if (index >= numberOfItems)
    return false;

  AffineTransformParametersItem* item = [self.affineTransformParametersItems objectAtIndex:index];
  [self stopObservingAffineTransformParametersItem:item];

  [self.affineTransformParametersItems removeObjectAtIndex:index];

  [self updateParametersDidChange];

  return true;
}

- (bool) moveUpItemAt:(NSUInteger)index
{
  if (index == 0)
    return false;

  NSUInteger numberOfItems = self.affineTransformParametersItems.count;
  if (index >= numberOfItems)
    return false;

  AffineTransformParametersItem* item = [self.affineTransformParametersItems objectAtIndex:index];
  [self.affineTransformParametersItems removeObjectAtIndex:index];

  NSUInteger reinsertIndex = index - 1;
  [self.affineTransformParametersItems insertObject:item atIndex:reinsertIndex];

  [self updateParametersDidChange];

  return true;
}

- (bool) moveDownItemAt:(NSUInteger)index
{
  NSUInteger indexOfLastItem = self.affineTransformParametersItems.count - 1;
  if (index >= indexOfLastItem)
    return false;

  AffineTransformParametersItem* item = [self.affineTransformParametersItems objectAtIndex:index];
  [self.affineTransformParametersItems removeObjectAtIndex:index];
  indexOfLastItem--;

  NSUInteger reinsertIndex = index + 1;
  if (reinsertIndex <= indexOfLastItem)
    [self.affineTransformParametersItems insertObject:item atIndex:reinsertIndex];
  else
    [self.affineTransformParametersItems addObject:item];

  [self updateParametersDidChange];

  return true;
}

#pragma mark - Manage items - Private API

- (void) removeAllItems
{
  for (AffineTransformParametersItem* item in self.affineTransformParametersItems)
    [self stopObservingAffineTransformParametersItem:item];
  [self.affineTransformParametersItems removeAllObjects];
}

#pragma mark - KVO

- (void) startObservingAffineTransformParametersItem:(AffineTransformParametersItem*)affineTransformParametersItem
{
  [affineTransformParametersItem addObserver:self forKeyPath:@"affineTransform" options:0 context:NULL];
}

- (void) stopObservingAffineTransformParametersItem:(AffineTransformParametersItem*)affineTransformParametersItem
{
  [affineTransformParametersItem removeObserver:self forKeyPath:@"affineTransform"];
}

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
  [self updateParametersDidChange];
}

- (void) updateParametersDidChange
{
  [self updateAffineTransform];
  [self updateAffineTransformAsString];
}

- (void) updateAffineTransform
{
  CGAffineTransform affineTransform = CGAffineTransformIdentity;

  for (AffineTransformParametersItem* item in self.affineTransformParametersItems)
    affineTransform = CGAffineTransformConcat(affineTransform, item.affineTransform);

  self.affineTransform = affineTransform;
}

- (void) updateAffineTransformAsString
{
  self.affineTransformAsString = [NSString stringWithFormat:@"%f, %f, %f, %f, %f, %f", _affineTransform.a, _affineTransform.b, _affineTransform.c, _affineTransform.d, _affineTransform.tx, _affineTransform.ty];
}

@end
