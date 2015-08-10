//
//  SWLoadMore.m
//  SinaWeather
//
//  Created by cui on 13-4-17.
//
//

#import "WLoadMore.h"
#import "UIView+Sizes.h"

#if ! __has_feature(objc_arc)
#error This file is ARC only. Either turn on ARC for the project or use -fobjc-arc flag
#endif

@interface WLoadMore ()
@property (strong, nonatomic) UIScrollView *scrollView;//必须强引用，不然内部观察将无法正确释放，在_finish 方法延时执行请下
@property (assign, nonatomic) CGFloat origBottomInset;
@property (assign, nonatomic) BOOL inLoadMore;
@end

@implementation WLoadMore

- (id)initWithScrollView:(UIScrollView *)scrollView
{
    self = [super init];
    if (self) {
        _scrollView = scrollView;
        [_scrollView addObserver:self
                      forKeyPath:@"contentOffset"
                         options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                         context:NULL];
        
        [_scrollView addObserver:self
                      forKeyPath:@"contentSize"
                         options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                         context:NULL];
    }
    return self;
}

- (void)dealloc
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [_scrollView removeObserver:self forKeyPath:@"contentSize"];
    self.delegate=nil;
}

- (void)triggerLoadMore
{
    if (self.loading) return;
    BOOL shouldStart = YES;
    if ([self.delegate respondsToSelector:@selector(loadMoreShouldTrigger:)]) {
        shouldStart = [self.delegate loadMoreShouldTrigger:self];
    }
    if (!shouldStart) return;

    BOOL shouldChangeInset = YES;
    if ([self.delegate respondsToSelector:@selector(loadMoreShouldChangeContentInset:enlarge:)]) {
        shouldChangeInset = [self.delegate loadMoreShouldChangeContentInset:self enlarge:YES];
    }
    
    if (shouldChangeInset) {
        UIEdgeInsets insets = self.scrollView.contentInset;
        insets.bottom = (self.origBottomInset + self.contentView.height);
        [self.scrollView setContentInset:insets];
    }
    self.loading = YES;
}

- (void)setContentView:(UIView *)contentView
{
    if (_contentView == contentView) return;
    _contentView = contentView;
    if (self.scrollView) {
        self.contentView.top = self.scrollView.contentSize.height;
        [self.scrollView addSubview:contentView];
        contentView.hidden=YES;
    }
}

- (void)setScrollView:(UIScrollView *)scrollView
{
    if (_scrollView == scrollView) return;
    [self.contentView removeFromSuperview];
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [_scrollView removeObserver:self forKeyPath:@"contentSize"];
    _scrollView = scrollView;
    self.contentView.top = self.scrollView.contentSize.height;
    [scrollView addSubview:self.contentView];
    [scrollView addObserver:self
                  forKeyPath:@"contentOffset"
                     options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                     context:NULL];
    
    [scrollView addObserver:self
                  forKeyPath:@"contentSize"
                     options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                     context:NULL];
    self.origBottomInset = self.scrollView.contentInset.bottom;
}

- (void)_finishLoading
{
    BOOL shouldChangeInset = YES;
    if ([self.delegate respondsToSelector:@selector(loadMoreShouldChangeContentInset:enlarge:)]) {
        shouldChangeInset = [self.delegate loadMoreShouldChangeContentInset:self enlarge:NO];
    }
    if (shouldChangeInset) {
        UIEdgeInsets insets = self.scrollView.contentInset;
        insets.bottom = self.origBottomInset;
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollView.contentInset = insets;
        }];
    }
    self.loading = NO;
}

- (void)finishLoading
{
    [self performSelector:@selector(_finishLoading)
               withObject:nil
               afterDelay:0];
}

- (void)setLoading:(BOOL)loading
{
    if (_loading == loading) return;
    _loading = loading;
    self.contentView.hidden=!loading;
    if (loading) {
        [self.delegate loadMoreDidTriggered:self];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == _scrollView) {
        if ([keyPath isEqualToString:@"contentOffset"]) {
            if (_scrollView.contentSize.height>_scrollView.frame.size.height-(_scrollView.contentInset.top+_scrollView.contentInset.bottom)) {
                CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
                CGPoint oldOffset = [change[NSKeyValueChangeOldKey] CGPointValue];
                if (offset.y > oldOffset.y &&
                    (offset.y + self.scrollView.bounds.size.height + self.threshold > self.scrollView.contentSize.height)) {
                    if (!self.inLoadMore) {
                        self.inLoadMore = YES;
                        [self triggerLoadMore];
                    }
                } else {
                    self.inLoadMore = NO;
                }
            }else{
//                NSLog(@"not need to load more");
            }
        } else if ([keyPath isEqualToString:@"contentSize"]) {
//            NSLog(@"note: %@", change);

            CGSize contenSize = [change[NSKeyValueChangeNewKey] CGSizeValue];
            self.contentView.top = contenSize.height;
        }
    }
}

@end
