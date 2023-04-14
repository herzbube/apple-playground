//
//  AffineTransformParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 25.03.23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AffineTransformParameters : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;
- (void) valuesDidChange;

- (NSUInteger) insertItemAt:(NSUInteger)index;
- (bool) removeItemAt:(NSUInteger)index;
- (bool) moveUpItemAt:(NSUInteger)index;
- (bool) moveDownItemAt:(NSUInteger)index;

@property bool affineTransformEnabled;
@property (strong, nonatomic) NSMutableArray* affineTransformParametersItems;
@property (nonatomic) CGAffineTransform affineTransform;
@property (strong, nonatomic) NSString* affineTransformAsString;

@end

NS_ASSUME_NONNULL_END
