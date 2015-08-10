//
//  SWAMCModel.h
//  SinaWeather
//
//  Created by iBcker on 14-6-28.
//
//

#import <Foundation/Foundation.h>

@interface ATCPropertyAttr : NSObject
@property (copy, nonatomic) NSString* name;
@property (assign, nonatomic) Class clazz;
@property (copy, nonatomic) NSString* protocol;
@end


@protocol ATCModelProtocol <NSObject>
@optional
- (NSArray *)ignoreCodingProperty;
- (void)decodeErrorKey:(NSString *)key propertyClass:(Class)clazz obj:(id)obj;

- (void)didSet:(NSString *)key vaule:(id)vaule property:(ATCPropertyAttr *)attr;

@end

@protocol ATCModel
@end

@interface ATCModel : NSObject<NSCoding,ATCModelProtocol>

+ (NSDictionary *)codableProperties;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)setWithCoder:(NSCoder *)aDecoder;

//property access
- (NSDictionary *)codableProperties;
- (NSDictionary *)dictionaryRepresentation;

//loading / saving

+ (instancetype)objectWithContentsOfFile:(NSString *)path;
- (BOOL)writeToFile:(NSString *)filePath atomically:(BOOL)useAuxiliaryFile;

- (NSData *)archiverToData;
+ (id)unArchiverWithData:(NSData *)rootData;

- (id)objectForKeyedSubscript:(id)key;
- (void)setObject:(id)obj forKeyedSubscript:(NSString *)key;

@end