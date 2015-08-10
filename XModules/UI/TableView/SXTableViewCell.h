//
//  SXTableViewCell.h
//  SXClient
//
//  Created by iBcker on 14-9-14.
//  Copyright (c) 2014年 SX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SXTableViewCell;

@protocol SXTableViewCellDelegate <NSObject>
@optional
- (void)sxCell:(SXTableViewCell *)cell onResponse:(SEL)sel withObjs:(NSArray *)objs;
@end

@protocol SXTableViewFillContentProtocol
@required
+ (CGFloat)heightForContent:(id)data limitWidth:(CGFloat)width ext:(id)ext;
@optional
- (void)onInitialize;
- (void)setContent:(id)content ext:(id)ext;
@end

@interface SXTableViewCell : UITableViewCell<SXTableViewFillContentProtocol>

@property (nonatomic,assign)BOOL showBottomLine;
@property (nonatomic,strong)UIColor *bottomLineColor; //default #DDDDDD
@property (nonatomic,assign)CGFloat bottomLinePadding; //default 0，当设置bottomLineInset时此值会不准，建议走bottomLineInset

@property (nonatomic,assign)UIEdgeInsets bottomLineInset; //default {0,0,0,0}

@property (nonatomic,assign)CGFloat bottomLineWeight; //default 0.5
@property (nonatomic,assign)BOOL selectEnable;

@property (nonatomic,strong)UIColor *selectBackgroundColor; //default nil

@property (nonatomic,strong)NSIndexPath *indexPath;

@property (nonatomic,weak)id content;

@property (nonatomic,weak)id <SXTableViewCellDelegate> delegate;

- (void)onInitialize;

///set content
+ (CGFloat)heightForContent:(id)content limitWidth:(CGFloat)width ext:(id)ext; //default 40
- (void)setContent:(id)content ext:(id)ext;//empty implement
@end

