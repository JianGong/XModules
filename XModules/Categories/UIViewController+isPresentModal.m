//
//  UIViewController+isPresentModal.m
//  SXClient
//
//  Created by iBcker on 14-5-13.
//
//

#import "UIViewController+isPresentModal.h"

@implementation UIViewController (isPresentModal)

- (BOOL)isPresentModal
{
    return self.presentingViewController.presentedViewController == self
    || (self.navigationController != nil &&
        self.navigationController.presentingViewController.presentedViewController == self.navigationController&&
        [self.navigationController.viewControllers indexOfObject:self]==0
        )
    || [self.tabBarController.presentingViewController isKindOfClass:[UITabBarController class]];
}
@end
