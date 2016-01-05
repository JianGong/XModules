//
//  SXTableViewAdapter.m
//  SXClient
//
//  Created by iBcker on 14-9-24.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import "SXTableViewDataSource.h"
#import "SXTableView.h"
#import "UIView+Sizes.h"
#import <objc/runtime.h>

#ifdef DEBUG
#define debug_count_cells 0
#endif

@interface SXTableViewCell(xib_fix)
@property (nonatomic,assign)BOOL is_created;
@end

@implementation SXTableViewCell(xib_fix)

const char is_created;

- (void)setIs_created:(BOOL)is_created
{
    objc_setAssociatedObject(self, &is_created, @(is_created), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)is_created
{
    return [objc_getAssociatedObject(self, &is_created) boolValue];
}

@end

@interface SXTableViewDataSource()<SXTableViewCellDelegate>

#if debug_count_cells
@property (nonatomic,strong)NSMutableDictionary *debugCellCounter;
#endif
@end

@implementation SXTableViewDataSource

- (id)initWithTableView:(UITableView *)tableView
{
    self = [super init];
    if (self) {
        _tableView=(SXTableView *)tableView;
        _tableView.dataSource=self;
    #if debug_count_cells
        _debugCellCounter=[NSMutableDictionary dictionary];
    #endif

    }
    return self;
}

- (void)dealloc
{
    self.delegate=nil;
    _tableView.dataSource=nil;
    _tableView=nil;
    self.objs=nil;
}

- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
    SXCellObj *object = [self objectAtIndexPath:indexPath];
    Class klass = object.clazz;
    id ext = [self extForCellAtIndexPath:indexPath];
    return [klass heightForContent:object.content limitWidth:_tableView.width ext:ext];
}

- (id)extForCellAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return self.objs[indexPath.section][indexPath.row];
}

- (void)tableView:(SXTableView *)tableView onCreateCell:(SXTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.showBottomLine=YES;
    cell.bottomLinePadding=8;
}

- (void)tableView:(SXTableView *)tableView onConfigCell:(SXTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.delegate=self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.objs[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.objs count];
}

- (SXTableViewCell *)sxtableView:(SXTableView *)tableView cellForObj:(SXCellObj *)obj
{
    return [[obj.clazz alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:obj.identifier];
}

- (UITableViewCell *)tableView:(SXTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXCellObj *obj=self.objs[indexPath.section][indexPath.row];
    NSString *identifier = obj.identifier;
    SXTableViewCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [self sxtableView:tableView cellForObj:obj];
        #if debug_count_cells
           if (!_debugCellCounter[identifier]) {
               _debugCellCounter[identifier]=@(1);
           }else{
               NSInteger cc=[_debugCellCounter[identifier] integerValue];
               _debugCellCounter[identifier]=@(cc+1);
           }
           NSLog(@"sxtablew initd %@, all cells:%@",identifier,[[_debugCellCounter allKeys] componentsJoinedByString:@","]);
        #endif
    }
    
    if(!cell.is_created){
        [self tableView:tableView onCreateCell:cell atIndexPath:indexPath];
        cell.is_created=YES;
    }
    
    cell.indexPath=indexPath;
    [self tableView:tableView onConfigCell:cell atIndexPath:indexPath];
    id ext = [self extForCellAtIndexPath:indexPath];
    [cell setContent:obj.content ext:ext];
    return cell;
}

- (void)sxCell:(SXTableViewCell *)cell onResponse:(SEL)sel withObjs:(NSArray *)objs
{
    if([self.delegate respondsToSelector:@selector(sxtableView:cell:onResponse:withObjs:)]){
        [self.delegate sxtableView:self.tableView cell:cell onResponse:sel withObjs:objs];
    }
}

@end
