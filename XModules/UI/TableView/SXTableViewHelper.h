//
//  SXTableViewHelper.h
//  SXClient
//
//  Created by iBcker on 14-9-25.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXCellObj : NSObject
@property (nonatomic,strong)NSString *identifier; //cell identifier ,default is cell's class name
@property (nonatomic,assign)Class clazz; //cell class
@property (nonatomic,strong)id content;//content data
@property (nonatomic,strong)id ext;//extension data
@end

extern SXCellObj *SXCellMake(Class cellClass, id content, id ext);

//extern SXCellObj *SXCellMakeWithXib(Class cellClass, id content, id ext);