//
//  SXTableView.m
//  SXClient
//
//  Created by iBcker on 14-9-15.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import "SXTableView.h"

@implementation UITableView(makeCell)
- (id)dequeueReusableCell:(Class)clazz withIdentifier:(NSString *)identifier
{
    id cell = [self dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[clazz alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}
- (id)dequeueReusableCellWithClass:(Class)identifierClazz
{
    return [self dequeueReusableCell:identifierClazz withIdentifier:NSStringFromClass(identifierClazz)];
}
@end

@implementation SXTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self=[super initWithFrame:frame style:style];
    if (self) {
        self.showsVerticalScrollIndicator=NO;
        self.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.showsVerticalScrollIndicator=NO;
    self.separatorStyle=UITableViewCellSeparatorStyleNone;
    if (self.backgroundColor == nil) {
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self=[self initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
    }
    return self;
}

- (void)setContentInset:(UIEdgeInsets)contentInset
{
    [super setContentInset:contentInset];
    self.scrollIndicatorInsets=contentInset;
}

@end
