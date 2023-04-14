//
//  DrawingParameters.h
//  core-graphics
//
//  Created by Patrick Näf Moser on 31.03.23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawingParameters : NSObject

- (instancetype) init;

- (NSDictionary*) valuesAsDictionary;
- (void) setValuesWithDictionary:(NSDictionary*)dictionary;

- (void) resetToDefaultValues;

- (NSUInteger) insertItemAt:(NSUInteger)index;
- (bool) removeItemAt:(NSUInteger)index;
- (bool) moveUpItemAt:(NSUInteger)index;
- (bool) moveDownItemAt:(NSUInteger)index;

- (void) readUserDefaults;
- (void) writeUserDefaults;

@property (strong, nonatomic) NSMutableArray* drawingParametersItems;

@end

NS_ASSUME_NONNULL_END
