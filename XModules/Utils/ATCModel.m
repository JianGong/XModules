//
//  SWAMCModel.m
//  SinaWeather
//
//  Created by iBcker on 14-6-28.
//
//

#import "ATCModel.h"
#import <objc/runtime.h>

@implementation NSArray (debugDescription)
//打印中文
-(NSString*)debugDescription
{
    NSMutableString *strs=[[NSMutableString alloc] initWithString:@"(\n"];
    for (id obj in self) {
        NSString *des;
        if ([obj isKindOfClass:[NSString class]]) {
            des = [NSString stringWithFormat:@"\"%@\"",[obj debugDescription]];
        }else if ([obj isKindOfClass:[NSNumber class]]){
            des = [NSString stringWithFormat:@"@(%@)",[obj debugDescription]];
        }else if ([obj isKindOfClass:[NSURL class]]){
            des=[NSString stringWithFormat:@"URL(%@)",[obj debugDescription]];
        }else{
            des=[obj debugDescription];
        }
        
        [strs appendFormat:@"%@,\n",des];
    }
    [strs appendString:@")"];
    return strs;
}
@end

@implementation NSDictionary (debugDescription)
//打印中文
-(NSString*)debugDescription
{
    NSMutableString *strs=[[NSMutableString alloc] initWithString:@"{\n"];
    NSArray *keys=[self allKeys];
    for (id key in keys) {
        id obj=[self objectForKey:key];
        
        NSString *des;
        if ([obj isKindOfClass:[NSString class]]) {
            des = [NSString stringWithFormat:@"\"%@\"",[obj debugDescription]];
        }else if ([obj isKindOfClass:[NSNumber class]]){
            des = [NSString stringWithFormat:@"@(%@)",[obj debugDescription]];
        }else if ([obj isKindOfClass:[NSURL class]]){
            des=[NSString stringWithFormat:@"URL(%@)",[obj debugDescription]];
        }else{
            des=[obj debugDescription];
        }
        
        [strs appendFormat:@"   %@ = %@ ;\n",key,des];
    }
    [strs appendString:@"}"];
    return strs;
}
@end

@implementation ATCPropertyAttr

- (NSString *)debugDescription
{
    NSString *str;
    if (self.protocol) {
        str=[NSString stringWithFormat:@"<attr:%@<%@>>",NSStringFromClass(self.clazz),self.protocol];
    }else{
        str=[NSString stringWithFormat:@"<attr:%@>",NSStringFromClass(self.clazz)];
    }
    return str;
}

@end

@implementation ATCModel

+ (BOOL)supportsSecureCoding
{
    return YES;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [[self.class allocWithZone:zone] initWithDictionary:self.dictionaryValue];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    
    self = [self init];
    if (self == nil) return nil;
    NSDictionary *ps =[self codableProperties];
    BOOL flagDidSetProperty=NO;
    if ([self respondsToSelector:@selector(didSet:vaule:property:)]) {
        flagDidSetProperty=YES;
    }
    for (NSString *key in ps) {
        id value = [dictionary objectForKey:key];
        ATCPropertyAttr *attr=ps[key];
        Class class =attr.clazz;
        if (value && [value isKindOfClass:class]) {
            [self setValue:value forKey:key];
        }
        if (flagDidSetProperty) {
            [self didSet:key vaule:value property:attr];
        }
    }
    return self;
}

- (NSDictionary *)dictionaryValue {
    return [self dictionaryWithValuesForKeys:[[[self class] codableProperties] allKeys]];
}

+ (instancetype)objectWithContentsOfFile:(NSString *)filePath
{
    //load the file
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    //attempt to deserialise data as a plist
    id object = nil;
    if (data)
    {
        NSPropertyListFormat format;
        object = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:&format error:NULL];
        
        //success?
        if (object)
        {
            //check if object is an NSCoded unarchive
            if ([object respondsToSelector:@selector(objectForKey:)] && [(NSDictionary *)object objectForKey:@"$archiver"])
            {
                object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            }
        }
        else
        {
            //return raw data
            object = data;
        }
    }
    
    //return object
    return object;
}

- (BOOL)writeToFile:(NSString *)filePath atomically:(BOOL)useAuxiliaryFile
{
    //note: NSData, NSDictionary and NSArray already implement this method
    //and do not save using NSCoding, however the objectWithContentsOfFile
    //method will correctly recover these objects anyway
    
    //archive object
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [data writeToFile:filePath atomically:useAuxiliaryFile];
}

+ (NSDictionary *)codableProperties
{
    unsigned int propertyCount;
    __autoreleasing NSMutableDictionary *codableProperties = [NSMutableDictionary dictionary];
    objc_property_t *properties = class_copyPropertyList(self, &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++)
    {
        //get property name
        objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);
        __autoreleasing NSString *key = @(propertyName);

        //get property type
        Class propertyClass = nil;
        ATCPropertyAttr *attr = [[ATCPropertyAttr alloc] init];
        attr.name=key;
        char *typeEncoding = property_copyAttributeValue(property, "T");
        switch (typeEncoding[0])
        {
            case '@':
            {
                if (strlen(typeEncoding) >= 3)
                {
                    char *className = strndup(typeEncoding + 2, strlen(typeEncoding) - 3);
                    __autoreleasing NSString *name = @(className);
                    NSRange range = [name rangeOfString:@"<"];
                    if (range.location != NSNotFound)
                    {
                        name = [name substringToIndex:range.location];
                    }
                    
                    char protocol[256];
                    if (sscanf(className,"%*[A-z_0-9]<%[A-z_0-9]>",protocol)>0) {
                        attr.protocol=[NSString stringWithUTF8String:protocol];
                    }else{
                        attr.protocol=nil;
                    }
                    propertyClass = NSClassFromString(name) ?: [NSObject class];
                    free(className);
                }
                break;
            }
            case 'c':
            case 'i':
            case 's':
            case 'l':
            case 'q':
            case 'C':
            case 'I':
            case 'S':
            case 'L':
            case 'Q':
            case 'f':
            case 'd':
            case 'B':
            {
                propertyClass = [NSNumber class];
                break;
            }
            case '{':
            {
                propertyClass = [NSValue class];
                break;
            }
        }
        free(typeEncoding);
        
        if (propertyClass)
        {
            
            //check if there is a backing ivar
            char *ivar = property_copyAttributeValue(property, "V");
            if (ivar)
            {
                //check if ivar has KVC-compliant name
                __autoreleasing NSString *ivarName = @(ivar);
                if ([ivarName isEqualToString:key] || [ivarName isEqualToString:[@"_" stringByAppendingString:key]])
                {
                    //no setter, but setValue:forKey: will still work
//                        codableProperties[key] = propertyClass;
                    attr.clazz=propertyClass;
                    codableProperties[key] = attr;
                }
                free(ivar);
            }
            else
            {
                //check if property is dynamic and readwrite
                char *dynamic = property_copyAttributeValue(property, "D");
                char *readonly = property_copyAttributeValue(property, "R");
                if (dynamic && !readonly)
                {
                    //no ivar, but setValue:forKey: will still work
//                        codableProperties[key] = propertyClass;
                    attr.clazz=propertyClass;
                    codableProperties[key] = attr;
                }
                free(dynamic);
                free(readonly);
            }
        }
    }
    
    free(properties);
    return codableProperties;
}

- (NSDictionary *)codableProperties
{
    __autoreleasing NSDictionary *codableProperties = objc_getAssociatedObject([self class], _cmd);
    if (!codableProperties)
    {
        codableProperties = [NSMutableDictionary dictionary];
        Class subclass = [self class];
        while (subclass != [NSObject class])
        {
            [(NSMutableDictionary *)codableProperties addEntriesFromDictionary:[subclass codableProperties]];
            subclass = [subclass superclass];
        }
        codableProperties = [NSDictionary dictionaryWithDictionary:codableProperties];
        
        if ([self respondsToSelector:@selector(ignoreCodingProperty)]) {
            NSArray *ignore = [self ignoreCodingProperty];
            if ([ignore count]>0) {
                NSMutableDictionary *res= [codableProperties mutableCopy];
                NSArray *keys = [res allKeys];
                for (NSString *key in keys) {
                    if ([ignore containsObject:key]) {
                        [res removeObjectForKey:key];
                    }
                }
                codableProperties = res;
            }
            
        }
        //make the association atomically so that we don't need to bother with an @synchronize
        objc_setAssociatedObject([self class], _cmd, codableProperties, OBJC_ASSOCIATION_RETAIN);
    }
    return codableProperties;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSDictionary *properties = [self codableProperties];
    for (NSString *key in properties)
    {
        id value = [self valueForKey:key];
        ATCPropertyAttr *attr=properties[key];
        Class class = attr.clazz;
        if ([value isKindOfClass:class]) {
            dict[key] = value;
        }
    }
    return dict;
}

- (void)setWithCoder:(NSCoder *)aDecoder
{
    BOOL secureAvailable = [aDecoder respondsToSelector:@selector(decodeObjectOfClass:forKey:)];
    BOOL secureSupported = [[self class] supportsSecureCoding];
    NSDictionary *properties = [self codableProperties];
    for (NSString *key in properties)
    {
        id object = nil;
        ATCPropertyAttr *attr = properties[key];
        Class propertyClass =attr.clazz;
        if (secureAvailable)
        {
            object = [aDecoder decodeObjectOfClass:propertyClass forKey:key];
        }
        else
        {
            object = [aDecoder decodeObjectForKey:key];
        }
        if (object)
        {
            if (secureSupported && ![object isKindOfClass:propertyClass]){
                if ([self respondsToSelector:@selector(decodeErrorKey:propertyClass:obj:)]) {
                    [self decodeErrorKey:key propertyClass:propertyClass obj:object];
                }else{
                    NSAssert(NO, @"Expected '%@' to be a %@, but was actually a %@", key, propertyClass, [object class]);
                }
            }else{
                [self setValue:object forKey:key];
            }
            
        }
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    [self setWithCoder:aDecoder];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    NSDictionary *properties = [self codableProperties];
    for (NSString *key in properties)
    {
        id object = [self valueForKey:key];
        ATCPropertyAttr *attr=properties[key];
        Class class = attr.clazz;
        if ([object isKindOfClass:class]) {
            [aCoder encodeObject:object forKey:key];
        }
    }
}

- (NSData *)archiverToData
{
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}

+ (id)unArchiverWithData:(NSData *)rootData
{
    id obj = [NSKeyedUnarchiver unarchiveObjectWithData:rootData];
    return [obj isKindOfClass:[self class]]?obj:nil;
}

- (id)objectForKeyedSubscript:(id)key
{
    return key?[self valueForKey:key]:nil;;
}

- (void)setObject:(id)obj forKeyedSubscript:(NSString *)key
{
    if (key) {
        [self setValue:obj forKey:key];
    }
}

- (void)setNilValueForKey:(NSString *)key
{
    NSAssert(NO, @"%@ setNilValueForKey:%@",self.class,key);
}

- (id)valueForUndefinedKey:(NSString *)key
{
    NSAssert(NO, @"%@ valueForUndefinedKey:%@",self.class,key);
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSAssert(NO, @"%@ setValue:%@forUndefinedKey:%@",self.class,value,key);
}

- (void)decodeErrorKey:(NSString *)key propertyClass:(Class)clazz obj:(id)obj
{
    NSAssert(NO, @"%@ decodeErrorKey:%@propertyClass:%@obj:%@",self.class,key,clazz,obj);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@",[self dictionaryRepresentation]];
}

- (NSString *)debugDescription
{
    NSMutableString *strs=[[NSMutableString alloc] initWithFormat:@"|-(%@ *)%p\n",[self class],self];
    NSDictionary *properties = [self codableProperties];
    for (NSString *key in properties)
    {
        id obj = [self valueForKey:key];
        NSString *des=nil;
        if ([obj isKindOfClass:[NSString class]]) {
            des = [NSString stringWithFormat:@"\"%@\"",[obj debugDescription]];
        }else if ([obj isKindOfClass:[NSNumber class]]){
            des = [NSString stringWithFormat:@"@(%@)",[obj debugDescription]];
        }else if ([obj isKindOfClass:[NSURL class]]){
            des=[NSString stringWithFormat:@"URL(%@)",[obj debugDescription]];
        }else{
            des=[obj debugDescription];
        }
        [strs appendFormat:@"| %@ = %@ ;\n",key,des];
    }
        return strs;
}
@end

