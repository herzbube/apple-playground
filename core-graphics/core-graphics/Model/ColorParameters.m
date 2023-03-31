//
//  ColorParameters.m
//  core-graphics
//
//  Created by Patrick Näf Moser on 24.03.23.
//

#import "ColorParameters.h"
#import "../Converter.h"

static NSString* redKey = @"red";
static NSString* greenKey = @"green";
static NSString* blueKey = @"blue";
static NSString* alphaKey = @"alpha";
static NSString* hexStringKey = @"hexString";

@implementation ColorParameters

- (instancetype) init
{
  self = [super init];

  [self initializeWithDefaultValues];

  return self;
}

- (void) initializeWithDefaultValues
{
  self.red = 1.0f;
  self.green = 0.0f;
  self.blue = 0.0f;
  self.alpha = 1.0f;
  self.hexString = @"FF0000FF";
}

- (NSDictionary*) valuesAsDictionary
{
  return
  @{
    redKey : @(self.red),
    greenKey : @(self.green),
    blueKey : @(self.blue),
    alphaKey : @(self.alpha),
    hexStringKey : self.hexString,
  };
}

- (void) setValuesWithDictionary:(NSDictionary*)dictionary
{
  self.red = [dictionary[redKey] floatValue];
  self.green = [dictionary[greenKey] floatValue];
  self.blue = [dictionary[blueKey] floatValue];
  self.alpha = [dictionary[alphaKey] floatValue];
  self.hexString = dictionary[hexStringKey];
}

- (void) updateWithHexString:(NSString*)hexString
{
  if ([hexString length] != 8)
    return;

  NSRange range = NSMakeRange(0, 2);
  NSString* redString = [hexString substringWithRange:range];
  range = NSMakeRange(2, 2);
  NSString* greenString = [hexString substringWithRange:range];
  range = NSMakeRange(4, 2);
  NSString* blueString = [hexString substringWithRange:range];
  range = NSMakeRange(6, 2);
  NSString* alphaString = [hexString substringWithRange:range];

  self.red = [Converter colorFractionFromColorComponentStringValue:redString];
  self.green = [Converter colorFractionFromColorComponentStringValue:greenString];
  self.blue = [Converter colorFractionFromColorComponentStringValue:blueString];
  self.alpha = [Converter colorFractionFromColorComponentStringValue:alphaString];
  self.hexString = hexString;
}

- (NSString*) hexStringFromColorComponentValues
{
  unsigned int red = [Converter colorComponentByteValueFromFractionValue:self.red];
  unsigned int green = [Converter colorComponentByteValueFromFractionValue:self.green];
  unsigned int blue = [Converter colorComponentByteValueFromFractionValue:self.blue];
  unsigned int alpha = [Converter colorComponentByteValueFromFractionValue:self.alpha];
  return [NSString stringWithFormat:@"%02X%02X%02X%02X", red, green, blue, alpha];
}

- (void) resetToDefaultValues
{
  [self initializeWithDefaultValues];
}

@end
