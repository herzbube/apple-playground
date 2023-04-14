//
//  DrawingParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 31.03.23.
//

#import "DrawingParameters.h"
#import "DrawingParametersItem.h"
#import "../../GlobalConstants.h"

static NSString* drawingParametersKey = @"drawingParameters";
static NSString* drawingParametersItemsKey = @"drawingParametersItems";

@implementation DrawingParameters

- (instancetype) init
{
  self = [super init];

  self.drawingParametersItems = [NSMutableArray array];
  
  [self initializeWithDefaultValues];

  return self;
}

- (void) initializeWithDefaultValues
{
  [self removeAllItems];
  [self insertItemAt:0];

  [self valuesDidChange];
}

- (NSDictionary*) valuesAsDictionary
{
  NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];

  NSMutableArray* itemValuesDictionaries = [NSMutableArray array];
  for (DrawingParametersItem* item in self.drawingParametersItems)
    [itemValuesDictionaries addObject:[item valuesAsDictionary]];
  dictionary[drawingParametersItemsKey] = itemValuesDictionaries;

  return dictionary;
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  if (! dictionary)
    return;

  [self removeAllItems];

  NSMutableArray* itemValuesDictionaries = dictionary[drawingParametersItemsKey];
  for (NSDictionary* itemValuesDictionary in itemValuesDictionaries)
  {
    DrawingParametersItem* item = [[DrawingParametersItem alloc] init];
    [item setValuesWithDictionary:itemValuesDictionary];

    [self.drawingParametersItems addObject:item];
  }

  [self valuesDidChange];
}

- (void) resetToDefaultValues
{
  [self initializeWithDefaultValues];
}

- (void) valuesDidChange
{
  [[NSNotificationCenter defaultCenter] postNotificationName:drawingParametersDidChange object:self];
}

#pragma mark - Manage items - Public API

- (NSUInteger) insertItemAt:(NSUInteger)index
{
  DrawingParametersItem* item = [[DrawingParametersItem alloc] init];

  NSUInteger indexOfNewItem;
  NSUInteger numberOfItems = self.drawingParametersItems.count;
  if (index < numberOfItems)
  {
    [self.drawingParametersItems insertObject:item atIndex:index];
    indexOfNewItem = index;
  }
  else
  {
    [self.drawingParametersItems addObject:item];
    indexOfNewItem = self.drawingParametersItems.count - 1;
  }

  [self valuesDidChange];

  return indexOfNewItem;
}

- (bool) removeItemAt:(NSUInteger)index
{
  NSUInteger numberOfItems = self.drawingParametersItems.count;
  if (index >= numberOfItems)
    return false;

  [self.drawingParametersItems removeObjectAtIndex:index];

  [self valuesDidChange];

  return true;
}

- (bool) moveUpItemAt:(NSUInteger)index
{
  if (index == 0)
    return false;

  NSUInteger numberOfItems = self.drawingParametersItems.count;
  if (index >= numberOfItems)
    return false;

  DrawingParametersItem* item = [self.drawingParametersItems objectAtIndex:index];
  [self.drawingParametersItems removeObjectAtIndex:index];

  NSUInteger reinsertIndex = index - 1;
  [self.drawingParametersItems insertObject:item atIndex:reinsertIndex];

  [self valuesDidChange];

  return true;
}

- (bool) moveDownItemAt:(NSUInteger)index
{
  NSUInteger indexOfLastItem = self.drawingParametersItems.count - 1;
  if (index >= indexOfLastItem)
    return false;

  DrawingParametersItem* item = [self.drawingParametersItems objectAtIndex:index];
  [self.drawingParametersItems removeObjectAtIndex:index];
  indexOfLastItem--;

  NSUInteger reinsertIndex = index + 1;
  if (reinsertIndex <= indexOfLastItem)
    [self.drawingParametersItems insertObject:item atIndex:reinsertIndex];
  else
    [self.drawingParametersItems addObject:item];

  [self valuesDidChange];

  return true;
}

#pragma mark - Manage items - Private API

- (void) removeAllItems
{
  [self.drawingParametersItems removeAllObjects];
}

#pragma mark - Read/write user defaults - Public API

- (void) readUserDefaults
{
  NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
  NSDictionary* dictionary = [userDefaults dictionaryForKey:drawingParametersKey];
  [self setValuesWithDictionary:dictionary];
}

- (void) writeUserDefaults
{
  NSDictionary* dictionary = [self valuesAsDictionary];
  NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults setObject:dictionary forKey:drawingParametersKey];
}

@end
