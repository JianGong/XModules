//
//  SXService.m
//  SXClient
//
//  Created by iBcker on 14-10-5.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import "SXService.h"
#import "SXApp.h"

@interface SXNetFormData()
@property (nonatomic,strong)NSData *formdData;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *fileName;
@property (nonatomic,strong)NSString *mimmeType;
@end

@implementation SXNetFormData

+ (instancetype)initWithForm:(NSData *)data name:(NSString *)name mimeType:(NSString *)mimeType
{
    return [self initWithForm:data name:name fileNmae:nil mimeType:mimeType];
}

+ (instancetype)initWithForm:(NSData *)data name:(NSString *)name fileNmae:(NSString *)fileName mimeType:(NSString *)mimeType
{
    SXNetFormData *obj=[[SXNetFormData alloc] init];
    obj.formdData=data;
    obj.name=name;
    obj.fileName=fileName;
    obj.mimmeType=mimeType;
    return obj;
}

@end

@implementation SXService

+ (NSString *)buildJsonPath:(NSString *)format,...
{
    if (!format){
        return nil;
    }
    va_list arglist;
    va_start(arglist, format);
    NSString *path=[[NSString alloc] initWithFormat:format arguments:arglist];
    return path;
}

+ (NSDictionary *)httpCommonParams:(NSDictionary *)pars
{
    return SXHTTPPARS(pars);
}

+ (NSString *)url:(NSString *)path
{
    if ([path hasPrefix:@"http://"]||[path hasPrefix:@"https://"]) {
        return path;
    }else{
        NSString *base=[self ApiServer];
        if (![base hasSuffix:@"/"]) {
            base=[base stringByAppendingString:@"/"];
        }
        return [NSString stringWithFormat:@"%@%@",base,path];
    }
}

+ (NSString *)ApiServer
{
    return @"http://baidu.com";
}

+ (NSDictionary *)defaultHeader
{
    return nil;
}

+ (BOOL)allowInvalidHttps
{
    return NO;
}

+ (AFHTTPRequestOperationManager *)operationManager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy.allowInvalidCertificates = self.allowInvalidHttps;
    return manager;
}

+ (AFHTTPRequestOperation *)get:(NSString *)path
                           pars:(id)parameters
                       complete:(void(^)(AFHTTPRequestOperation *operation,id responseObject,NSError *error))complete
{
    return [self get:path pars:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        complete(operation,responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        complete(operation,operation.responseObject,error);
    }];
}

+ (AFHTTPRequestOperation *)post:(NSString *)path
                            pars:(id)parameters
                        complete:(void(^)(AFHTTPRequestOperation *operation,id responseObject,NSError *error))complete
{
    return [self post:path pars:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        complete(operation,responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        complete(operation,operation.responseObject,error);
    }];
}

+ (AFHTTPRequestOperation *)post:(NSString *)path
                            pars:(id)parameters
                        formData:(SXNetFormData *)data
                        complete:(void(^)(AFHTTPRequestOperation *operation,id responseObject,NSError *error))complete
{
    AFHTTPRequestOperationManager *manager = [self operationManager];
    
    [[self defaultHeader] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    return [manager POST:[self url:path] parameters:[self httpCommonParams:parameters] constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (data) {
            if (data.fileName) {
                [formData appendPartWithFileData:data.formdData name:data.name fileName:data.fileName mimeType:data.mimmeType];
            }else{
                [formData appendPartWithFormData:data.formdData name:data.name];
            }
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (complete) {
            complete(operation,responseObject,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (complete) {
            complete(operation,operation.responseObject,error);
        }
    }];
}

+ (AFHTTPRequestOperation *)del:(NSString *)path
                           pars:(id)parameters
                       complete:(void(^)(AFHTTPRequestOperation *operation,id responseObject,NSError *error))complete
{
    return [self del:path pars:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        complete(operation,responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        complete(operation,operation.responseObject,error);
    }];
}

+ (AFHTTPRequestOperation *)del:(NSString *)path
                           pars:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [self operationManager];
    
    [[self defaultHeader] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    return [manager DELETE:[self url:path] parameters:[self httpCommonParams:parameters] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}


+ (AFHTTPRequestOperation *)get:(NSString *)path
                           pars:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    AFHTTPRequestOperationManager *manager = [self operationManager];
    
    [[self defaultHeader] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    return [manager GET:[self url:path] parameters:[self httpCommonParams:parameters] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}

+ (AFHTTPRequestOperation *)post:(NSString *)path
                            pars:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [self operationManager];
    
    [[self defaultHeader] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    return [manager POST:[self url:path] parameters:[self httpCommonParams:parameters] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
}

+ (AFHTTPRequestOperation *)post:(NSString *)path
                             raw:(NSData *)raw
                        complete:(void(^)(AFHTTPRequestOperation *operation,id responseObject,NSError *error))complete
{
    AFHTTPRequestOperationManager *manager = [self operationManager];
    
    NSError *serializationError = nil;
    [[self defaultHeader] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:[self url:path] parameters:nil error:&serializationError];
    
    if (serializationError) {
        if (complete) {
            complete(nil,nil,serializationError);
        }
        return nil;
    }else{
        
        NSUInteger postLength = raw.length;
        NSString *contentLength = [NSString stringWithFormat:@"%td", postLength];
        [request addValue:contentLength forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:raw];
        
        AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (complete) {
                complete(operation,responseObject,nil);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (complete) {
                complete(operation,operation.responseObject,error);
            }
        }];
        [manager.operationQueue addOperation:operation];
        return operation;
    }
}
@end
