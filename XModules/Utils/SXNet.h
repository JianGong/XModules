//
//  SXNet.h
//  SXClient
//
//  Created by iBcker on 14-10-5.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface SXNetFormData : NSObject

/**
 post form
 :data
 :form's name
 :mimeType ,file mimeType eg. @"image/jpeg"
 */
+ (instancetype)initWithForm:(NSData *)data name:(NSString *)name mimeType:(NSString *)mimeType;

/**
 post form to upload file
 :data
 :form's name
 :upload fileName
 :mimeType ,file mimeType eg. @"image/jpeg"
 */
+ (instancetype)initWithForm:(NSData *)data name:(NSString *)name fileNmae:(NSString *)fileName mimeType:(NSString *)mimeType;
@end

@interface SXNet : NSObject

// rewrite to set api server address
+ (NSString *)ApiServer;
+ (NSDictionary *)defaultHeader;//default is nil

+ (AFHTTPRequestOperationManager *)operationManager;

+ (BOOL)allowInvalidHttps;

//添加公用参数
+ (NSDictionary *)httpCommonParams:(NSDictionary *)pars;

/**
 构建请求地址后半部分，类似nsstring formater的作用  
 eg. [SXNet buildJsonPath:@"users/%zd.json",uid]
 */
+ (NSString *)buildJsonPath:(NSString *)format,...;

+ (AFHTTPRequestOperation *)get:(NSString *)path
                           pars:(id)parameters
                        complete:(void(^)(AFHTTPRequestOperation *operation,id responseObject,NSError *error))complete;

+ (AFHTTPRequestOperation *)post:(NSString *)path
                            pars:(id)parameters
                        complete:(void(^)(AFHTTPRequestOperation *operation,id responseObject,NSError *error))complete;

+ (AFHTTPRequestOperation *)post:(NSString *)path
                            pars:(id)parameters
                            formData:(SXNetFormData *)formData
                        complete:(void(^)(AFHTTPRequestOperation *operation,id responseObject,NSError *error))complete;

+ (AFHTTPRequestOperation *)post:(NSString *)path
                             raw:(NSData *)raw
                        complete:(void(^)(AFHTTPRequestOperation *operation,id responseObject,NSError *error))complete;

+ (AFHTTPRequestOperation *)del:(NSString *)path
                            pars:(id)parameters
                        complete:(void(^)(AFHTTPRequestOperation *operation,id responseObject,NSError *error))complete;

@end
