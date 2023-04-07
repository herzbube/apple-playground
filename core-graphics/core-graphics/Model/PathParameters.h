//
//  PathParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 31.03.23.
//

#import <UIKit/UIKit.h>

@class ArcParameters;
@class RectangleParameters;

typedef NS_ENUM(NSInteger, PathType)
{
  PathTypeArc,
  PathTypeRectangle,
};

NS_ASSUME_NONNULL_BEGIN

@interface PathParameters : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;

@property bool pathEnabled;
@property PathType pathType;
@property (strong, nonatomic) ArcParameters* arcParameters;
@property (strong, nonatomic) RectangleParameters* rectangleParameters;

@end

NS_ASSUME_NONNULL_END
