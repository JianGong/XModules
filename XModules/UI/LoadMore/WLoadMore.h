
//
//  SWLoadMore.h
//  SinaWeather
//
//  Created by cui on 13-4-17.
//
//

#import <UIKit/UIKit.h>

/**
 * 加到UISrollView中即可
 * 需要传入一个contentView, 大小自己指定
 * threshold 下拉多少像素触发, 一般与contentView.height相同
 * loading   UI状态是否为加载中
 */

@protocol WLoadMoreDelegate;

@interface WLoadMore : NSObject
@property (weak,nonatomic) id <WLoadMoreDelegate> delegate;
@property (strong, nonatomic) UIView *contentView;
@property (nonatomic) CGFloat threshold;
@property (nonatomic) BOOL loading;

- (id)initWithScrollView:(UIScrollView *)scrollView;
- (void)finishLoading; // 结束加载中的状态
@end

@protocol WLoadMoreDelegate <NSObject>
// 返回YES则进入加载更多形态
- (BOOL)loadMoreShouldTrigger:(WLoadMore *)loadMore;
// 进入加载形态后被调用 当 设置loading = YES时触发，跟用KVO一样的效果
- (void)loadMoreDidTriggered:(WLoadMore *)loadMore;
@optional
// 把inset变大时enlarge为YES 否则为 NO
- (BOOL)loadMoreShouldChangeContentInset:(WLoadMore *)loadMore enlarge:(BOOL)enlarge;
@end