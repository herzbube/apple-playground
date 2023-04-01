//
//  RectangleParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 31.03.23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RectangleParameters : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;

@property CGFloat originX;
@property (readonly) CGFloat maximumOriginX;

@property CGFloat originY;
@property (readonly) CGFloat maximumOriginY;

@property CGFloat width;
@property (readonly) CGFloat maximumWidth;

@property CGFloat height;
@property (readonly) CGFloat maximumHeight;

@end

NS_ASSUME_NONNULL_END
