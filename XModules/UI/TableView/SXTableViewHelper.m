//
//  SXTableViewHelper.m
//  SXClient
//
//  Created by iBcker on 14-9-25.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import "SXTableViewHelper.h"

//typedef struct CellModule{
//    __weak NSString *identifier;
//    __weak id content;
//    __weak id ext;
//}acll;


SXCellObj *SXCellMake(Class cellClass, id content, id ext)
{
    NSCAssert(cellClass, @"cell calss can't be nil");
    SXCellObj *item = [[SXCellObj alloc] init];
    item.identifier=NSStringFromClass(cellClass);
    item.clazz=cellClass;
    item.content=content;
    item.ext=ext;
    return item;
}


@implementation SXCellObj

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"<%@: %p identifier:%@ clazz:%@ content:%@\next:%@>",self.class,self,self.identifier,self.clazz,self.content,self.ext];
}

@end
